import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._init();
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('weather.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return openDatabase(
      path, 
      version: 1, 
      onCreate: _createDB,
      onUpgrade: _upgradeDB,
    );
  }

  Future<void> _upgradeDB(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('DROP TABLE IF EXISTS favorites');
      await _createFavoritesTable(db);
    }
  }

  Future<void> _createDB(Database db, int version) async {
    await _createFavoritesTable(db);

    // Create weather cache table
    await db.execute('''
    CREATE TABLE weather_cache (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      lat REAL NOT NULL,
      lon REAL NOT NULL,
      weather_data TEXT NOT NULL,
      cached_at INTEGER NOT NULL,
      type TEXT NOT NULL,
      UNIQUE(lat, lon, type)
    )
    ''');
  }

  Future<void> _createFavoritesTable(Database db) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const jsonType = 'TEXT NOT NULL';
    const dateTimeType = 'TEXT NOT NULL';

    await db.execute('''
    CREATE TABLE favorites (
      id $idType,
      json $jsonType,
      date_time $dateTimeType
    )
    ''');
  }

  Future<int> create(Map<String, dynamic> favorite) async {
    final db = await instance.database;
    return db.insert('favorites', favorite);
  }

  Future<Map<String, dynamic>?> readFavorite(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      'favorites',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return maps.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> readAllFavorites() async {
    final db = await instance.database;
    return db.query('favorites');
  }

  Future<int> update(String id, Map<String, dynamic> favorite) async {
    final db = await instance.database;
    return db.update(
      'favorites',
      favorite,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return db.delete(
      'favorites',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> close() async {
    final db = await instance.database;
    await db.close();
  }

  // Weather caching methods
  Future<int> cacheWeatherData(Map<String, dynamic> cacheData) async {
    final db = await instance.database;
    return db.insert(
      'weather_cache',
      cacheData,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Map<String, dynamic>?> getCachedWeather(double lat, double lon) async {
    final db = await instance.database;
    final results = await db.query(
      'weather_cache',
      where: 'lat = ? AND lon = ? AND type = ?',
      whereArgs: [lat, lon, 'weather'],
      limit: 1,
    );

    return results.isNotEmpty ? results.first : null;
  }

  Future<Map<String, dynamic>?> getCachedForecast(
    double lat,
    double lon,
  ) async {
    final db = await instance.database;
    final results = await db.query(
      'weather_cache',
      where: 'lat = ? AND lon = ? AND type = ?',
      whereArgs: [lat, lon, 'forecast'],
      limit: 1,
    );

    return results.isNotEmpty ? results.first : null;
  }

  Future<int> deleteCachedWeather(double lat, double lon) async {
    final db = await instance.database;
    return db.delete(
      'weather_cache',
      where: 'lat = ? AND lon = ? AND type = ?',
      whereArgs: [lat, lon, 'weather'],
    );
  }

  Future<int> deleteCachedForecast(double lat, double lon) async {
    final db = await instance.database;
    return db.delete(
      'weather_cache',
      where: 'lat = ? AND lon = ? AND type = ?',
      whereArgs: [lat, lon, 'forecast'],
    );
  }

  Future<int> clearExpiredWeatherCache(
    int weatherExpiryTime,
    int forecastExpiryTime,
  ) async {
    final db = await instance.database;

    // Clear expired weather cache
    final weatherDeleted = await db.delete(
      'weather_cache',
      where: 'type = ? AND cached_at < ?',
      whereArgs: ['weather', weatherExpiryTime],
    );

    // Clear expired forecast cache
    final forecastDeleted = await db.delete(
      'weather_cache',
      where: 'type = ? AND cached_at < ?',
      whereArgs: ['forecast', forecastExpiryTime],
    );

    return weatherDeleted + forecastDeleted;
  }

  Future<int> clearAllWeatherCache() async {
    final db = await instance.database;
    return db.delete('weather_cache');
  }
}
