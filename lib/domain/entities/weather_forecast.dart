// Import shared entities from weather.dart
import 'package:climora/domain/entities/weather.dart'
    show Clouds, Coord, WeatherInfo;

class WeatherForecast {
  const WeatherForecast({
    required this.cod,
    required this.message,
    required this.cnt,
    required this.list,
    required this.city,
  });

  factory WeatherForecast.fromMap(Map<String, dynamic> json) => WeatherForecast(
    cod: json['cod'] as String? ?? '',
    message: json['message'] as int? ?? 0,
    cnt: json['cnt'] as int? ?? 0,
    list: List<ForecastItem>.from(
      (json['list'] as List? ?? []).map(
        (x) => ForecastItem.fromMap(x as Map<String, dynamic>),
      ),
    ),
    city: City.fromMap(json['city'] as Map<String, dynamic>? ?? {}),
  );

  Map<String, dynamic> toMap() => {
    'cod': cod,
    'message': message,
    'cnt': cnt,
    'list': List<dynamic>.from(list.map((x) => x.toMap())),
    'city': city.toMap(),
  };

  WeatherForecast copyWith({
    String? cod,
    int? message,
    int? cnt,
    List<ForecastItem>? list,
    City? city,
  }) => WeatherForecast(
    cod: cod ?? this.cod,
    message: message ?? this.message,
    cnt: cnt ?? this.cnt,
    list: list ?? this.list,
    city: city ?? this.city,
  );

  final String cod;
  final int message;
  final int cnt;
  final List<ForecastItem> list;
  final City city;
}

class ForecastItem {
  const ForecastItem({
    required this.dt,
    required this.main,
    required this.weather,
    required this.clouds,
    required this.wind,
    required this.visibility,
    required this.pop,
    required this.sys,
    required this.dtTxt,
  });

  factory ForecastItem.fromMap(Map<String, dynamic> json) => ForecastItem(
    dt: json['dt'] as int? ?? 0,
    main: ForecastMain.fromMap(
      json['main'] as Map<String, dynamic>? ?? {},
    ),
    weather: List<WeatherInfo>.from(
      (json['weather'] as List? ?? []).map(
        (x) => WeatherInfo.fromMap(x as Map<String, dynamic>),
      ),
    ),
    clouds: Clouds.fromMap(
      json['clouds'] as Map<String, dynamic>? ?? {},
    ),
    wind: ForecastWind.fromMap(
      json['wind'] as Map<String, dynamic>? ?? {},
    ),
    visibility: json['visibility'] as int? ?? 0,
    pop: (json['pop'] as num?)?.toDouble() ?? 0.0,
    sys: ForecastSys.fromMap(
      json['sys'] as Map<String, dynamic>? ?? {},
    ),
    dtTxt: json['dt_txt'] as String? ?? '',
  );

  Map<String, dynamic> toMap() => {
    'dt': dt,
    'main': main.toMap(),
    'weather': List<dynamic>.from(weather.map((x) => x.toMap())),
    'clouds': clouds.toMap(),
    'wind': wind.toMap(),
    'visibility': visibility,
    'pop': pop,
    'sys': sys.toMap(),
    'dt_txt': dtTxt,
  };

  ForecastItem copyWith({
    int? dt,
    ForecastMain? main,
    List<WeatherInfo>? weather,
    Clouds? clouds,
    ForecastWind? wind,
    int? visibility,
    double? pop,
    ForecastSys? sys,
    String? dtTxt,
  }) => ForecastItem(
    dt: dt ?? this.dt,
    main: main ?? this.main,
    weather: weather ?? this.weather,
    clouds: clouds ?? this.clouds,
    wind: wind ?? this.wind,
    visibility: visibility ?? this.visibility,
    pop: pop ?? this.pop,
    sys: sys ?? this.sys,
    dtTxt: dtTxt ?? this.dtTxt,
  );

  final int dt;
  final ForecastMain main;
  final List<WeatherInfo> weather;
  final Clouds clouds;
  final ForecastWind wind;
  final int visibility;
  final double pop;
  final ForecastSys sys;
  final String dtTxt;
}

class ForecastMain {
  const ForecastMain({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.seaLevel,
    required this.grndLevel,
    required this.humidity,
    required this.tempKf,
  });

  factory ForecastMain.fromMap(Map<String, dynamic> json) => ForecastMain(
    temp: (json['temp'] as num?)?.toDouble() ?? 0.0,
    feelsLike: (json['feels_like'] as num?)?.toDouble() ?? 0.0,
    tempMin: (json['temp_min'] as num?)?.toDouble() ?? 0.0,
    tempMax: (json['temp_max'] as num?)?.toDouble() ?? 0.0,
    pressure: json['pressure'] as int? ?? 0,
    seaLevel: json['sea_level'] as int? ?? 0,
    grndLevel: json['grnd_level'] as int? ?? 0,
    humidity: json['humidity'] as int? ?? 0,
    tempKf: (json['temp_kf'] as num?)?.toDouble() ?? 0.0,
  );

  Map<String, dynamic> toMap() => {
    'temp': temp,
    'feels_like': feelsLike,
    'temp_min': tempMin,
    'temp_max': tempMax,
    'pressure': pressure,
    'sea_level': seaLevel,
    'grnd_level': grndLevel,
    'humidity': humidity,
    'temp_kf': tempKf,
  };

  ForecastMain copyWith({
    double? temp,
    double? feelsLike,
    double? tempMin,
    double? tempMax,
    int? pressure,
    int? seaLevel,
    int? grndLevel,
    int? humidity,
    double? tempKf,
  }) => ForecastMain(
    temp: temp ?? this.temp,
    feelsLike: feelsLike ?? this.feelsLike,
    tempMin: tempMin ?? this.tempMin,
    tempMax: tempMax ?? this.tempMax,
    pressure: pressure ?? this.pressure,
    seaLevel: seaLevel ?? this.seaLevel,
    grndLevel: grndLevel ?? this.grndLevel,
    humidity: humidity ?? this.humidity,
    tempKf: tempKf ?? this.tempKf,
  );

  final double temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int pressure;
  final int seaLevel;
  final int grndLevel;
  final int humidity;
  final double tempKf;
}

class ForecastWind {
  const ForecastWind({
    required this.speed,
    required this.deg,
    required this.gust,
  });

  factory ForecastWind.fromMap(Map<String, dynamic> json) => ForecastWind(
    speed: (json['speed'] as num?)?.toDouble() ?? 0.0,
    deg: json['deg'] as int? ?? 0,
    gust: (json['gust'] as num?)?.toDouble() ?? 0.0,
  );

  Map<String, dynamic> toMap() => {
    'speed': speed,
    'deg': deg,
    'gust': gust,
  };

  ForecastWind copyWith({
    double? speed,
    int? deg,
    double? gust,
  }) => ForecastWind(
    speed: speed ?? this.speed,
    deg: deg ?? this.deg,
    gust: gust ?? this.gust,
  );

  final double speed;
  final int deg;
  final double gust;
}

class ForecastSys {
  const ForecastSys({
    required this.pod,
  });

  factory ForecastSys.fromMap(Map<String, dynamic> json) => ForecastSys(
    pod: json['pod'] as String? ?? '',
  );

  Map<String, dynamic> toMap() => {
    'pod': pod,
  };

  ForecastSys copyWith({
    String? pod,
  }) => ForecastSys(
    pod: pod ?? this.pod,
  );

  final String pod;
}

class City {
  const City({
    required this.id,
    required this.name,
    required this.coord,
    required this.country,
    required this.population,
    required this.timezone,
    required this.sunrise,
    required this.sunset,
  });

  factory City.fromMap(Map<String, dynamic> json) => City(
    id: json['id'] as int? ?? 0,
    name: json['name'] as String? ?? '',
    coord: Coord.fromMap(
      json['coord'] as Map<String, dynamic>? ?? {},
    ),
    country: json['country'] as String? ?? '',
    population: json['population'] as int? ?? 0,
    timezone: json['timezone'] as int? ?? 0,
    sunrise: json['sunrise'] as int? ?? 0,
    sunset: json['sunset'] as int? ?? 0,
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'coord': coord.toMap(),
    'country': country,
    'population': population,
    'timezone': timezone,
    'sunrise': sunrise,
    'sunset': sunset,
  };

  City copyWith({
    int? id,
    String? name,
    Coord? coord,
    String? country,
    int? population,
    int? timezone,
    int? sunrise,
    int? sunset,
  }) => City(
    id: id ?? this.id,
    name: name ?? this.name,
    coord: coord ?? this.coord,
    country: country ?? this.country,
    population: population ?? this.population,
    timezone: timezone ?? this.timezone,
    sunrise: sunrise ?? this.sunrise,
    sunset: sunset ?? this.sunset,
  );

  final int id;
  final String name;
  final Coord coord;
  final String country;
  final int population;
  final int timezone;
  final int sunrise;
  final int sunset;
}
