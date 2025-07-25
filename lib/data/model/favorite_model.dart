class FavoriteModel {
  const FavoriteModel({
    required this.id,
    required this.json,
    required this.dateTime,
  });

  //fromMap
  factory FavoriteModel.fromMap(Map<String, dynamic> map) {
    return FavoriteModel(
      id: map['id'] as int,
      json: map['json'] as String,
      dateTime: map['date_time'] as String,
    );
  }

  final int id;
  final String json;
  final String dateTime;

  //toMap
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'json': json,
      'date_time': dateTime,
    };
  }

  //toMapForInsert - excludes ID for auto-increment
  Map<String, dynamic> toMapForInsert() {
    return {
      'json': json,
      'date_time': dateTime,
    };
  }
}
