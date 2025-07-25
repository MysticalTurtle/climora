class WeatherModel {
  const WeatherModel({
    required this.coord,
    required this.weather,
    required this.base,
    required this.main,
    required this.visibility,
    required this.wind,
    required this.clouds,
    required this.dt,
    required this.sys,
    required this.timezone,
    required this.id,
    required this.name,
    required this.cod,
  });

  factory WeatherModel.fromMap(Map<String, dynamic> json) => WeatherModel(
    coord: CoordModel.fromMap(json['coord'] as Map<String, dynamic>? ?? {}),
    weather: List<WeatherInfoModel>.from(
      (json['weather'] as List? ?? []).map(
        (x) => WeatherInfoModel.fromMap(x as Map<String, dynamic>),
      ),
    ),
    base: json['base'] as String? ?? '',
    main: MainModel.fromMap(json['main'] as Map<String, dynamic>? ?? {}),
    visibility: json['visibility'] as int? ?? 0,
    wind: WindModel.fromMap(json['wind'] as Map<String, dynamic>? ?? {}),
    clouds: CloudsModel.fromMap(json['clouds'] as Map<String, dynamic>? ?? {}),
    dt: json['dt'] as int? ?? 0,
    sys: SysModel.fromMap(json['sys'] as Map<String, dynamic>? ?? {}),
    timezone: json['timezone'] as int? ?? 0,
    id: json['id'] as int? ?? 0,
    name: json['name'] as String? ?? '',
    cod: json['cod'] as int? ?? 0,
  );

  Map<String, dynamic> toMap() => {
    'coord': coord.toMap(),
    'weather': List<dynamic>.from(weather.map((x) => x.toMap())),
    'base': base,
    'main': main.toMap(),
    'visibility': visibility,
    'wind': wind.toMap(),
    'clouds': clouds.toMap(),
    'dt': dt,
    'sys': sys.toMap(),
    'timezone': timezone,
    'id': id,
    'name': name,
    'cod': cod,
  };

  WeatherModel copyWith({
    CoordModel? coord,
    List<WeatherInfoModel>? weather,
    String? base,
    MainModel? main,
    int? visibility,
    WindModel? wind,
    CloudsModel? clouds,
    int? dt,
    SysModel? sys,
    int? timezone,
    int? id,
    String? name,
    int? cod,
  }) => WeatherModel(
    coord: coord ?? this.coord,
    weather: weather ?? this.weather,
    base: base ?? this.base,
    main: main ?? this.main,
    visibility: visibility ?? this.visibility,
    wind: wind ?? this.wind,
    clouds: clouds ?? this.clouds,
    dt: dt ?? this.dt,
    sys: sys ?? this.sys,
    timezone: timezone ?? this.timezone,
    id: id ?? this.id,
    name: name ?? this.name,
    cod: cod ?? this.cod,
  );

  final CoordModel coord;
  final List<WeatherInfoModel> weather;
  final String base;
  final MainModel main;
  final int visibility;
  final WindModel wind;
  final CloudsModel clouds;
  final int dt;
  final SysModel sys;
  final int timezone;
  final int id;
  final String name;
  final int cod;
}

class CoordModel {
  const CoordModel({
    required this.lon,
    required this.lat,
  });

  factory CoordModel.fromMap(Map<String, dynamic> json) => CoordModel(
    lon: (json['lon'] as num?)?.toDouble() ?? 0.0,
    lat: (json['lat'] as num?)?.toDouble() ?? 0.0,
  );

  Map<String, dynamic> toMap() => {
    'lon': lon,
    'lat': lat,
  };

  CoordModel copyWith({
    double? lon,
    double? lat,
  }) => CoordModel(
    lon: lon ?? this.lon,
    lat: lat ?? this.lat,
  );

  final double lon;
  final double lat;
}

class WeatherInfoModel {
  const WeatherInfoModel({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  factory WeatherInfoModel.fromMap(Map<String, dynamic> json) =>
      WeatherInfoModel(
        id: json['id'] as int? ?? 0,
        main: json['main'] as String? ?? '',
        description: json['description'] as String? ?? '',
        icon: json['icon'] as String? ?? '',
      );

  Map<String, dynamic> toMap() => {
    'id': id,
    'main': main,
    'description': description,
    'icon': icon,
  };

  WeatherInfoModel copyWith({
    int? id,
    String? main,
    String? description,
    String? icon,
  }) => WeatherInfoModel(
    id: id ?? this.id,
    main: main ?? this.main,
    description: description ?? this.description,
    icon: icon ?? this.icon,
  );

  final int id;
  final String main;
  final String description;
  final String icon;
}

class MainModel {
  const MainModel({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
    required this.seaLevel,
    required this.grndLevel,
  });

  factory MainModel.fromMap(Map<String, dynamic> json) => MainModel(
    temp: (json['temp'] as num?)?.toDouble() ?? 0.0,
    feelsLike: (json['feels_like'] as num?)?.toDouble() ?? 0.0,
    tempMin: (json['temp_min'] as num?)?.toDouble() ?? 0.0,
    tempMax: (json['temp_max'] as num?)?.toDouble() ?? 0.0,
    pressure: json['pressure'] as int? ?? 0,
    humidity: json['humidity'] as int? ?? 0,
    seaLevel: json['sea_level'] as int? ?? 0,
    grndLevel: json['grnd_level'] as int? ?? 0,
  );

  Map<String, dynamic> toMap() => {
    'temp': temp,
    'feels_like': feelsLike,
    'temp_min': tempMin,
    'temp_max': tempMax,
    'pressure': pressure,
    'humidity': humidity,
    'sea_level': seaLevel,
    'grnd_level': grndLevel,
  };

  MainModel copyWith({
    double? temp,
    double? feelsLike,
    double? tempMin,
    double? tempMax,
    int? pressure,
    int? humidity,
    int? seaLevel,
    int? grndLevel,
  }) => MainModel(
    temp: temp ?? this.temp,
    feelsLike: feelsLike ?? this.feelsLike,
    tempMin: tempMin ?? this.tempMin,
    tempMax: tempMax ?? this.tempMax,
    pressure: pressure ?? this.pressure,
    humidity: humidity ?? this.humidity,
    seaLevel: seaLevel ?? this.seaLevel,
    grndLevel: grndLevel ?? this.grndLevel,
  );

  final double temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int pressure;
  final int humidity;
  final int seaLevel;
  final int grndLevel;
}

class WindModel {
  const WindModel({
    required this.speed,
    required this.deg,
  });

  factory WindModel.fromMap(Map<String, dynamic> json) => WindModel(
    speed: (json['speed'] as num?)?.toDouble() ?? 0.0,
    deg: json['deg'] as int? ?? 0,
  );

  Map<String, dynamic> toMap() => {
    'speed': speed,
    'deg': deg,
  };

  WindModel copyWith({
    double? speed,
    int? deg,
  }) => WindModel(
    speed: speed ?? this.speed,
    deg: deg ?? this.deg,
  );

  final double speed;
  final int deg;
}

class CloudsModel {
  const CloudsModel({
    required this.all,
  });

  factory CloudsModel.fromMap(Map<String, dynamic> json) => CloudsModel(
    all: json['all'] as int? ?? 0,
  );

  Map<String, dynamic> toMap() => {
    'all': all,
  };

  CloudsModel copyWith({
    int? all,
  }) => CloudsModel(
    all: all ?? this.all,
  );

  final int all;
}

class SysModel {
  const SysModel({
    required this.type,
    required this.id,
    required this.country,
    required this.sunrise,
    required this.sunset,
  });

  factory SysModel.fromMap(Map<String, dynamic> json) => SysModel(
    type: json['type'] as int? ?? 0,
    id: json['id'] as int? ?? 0,
    country: json['country'] as String? ?? '',
    sunrise: json['sunrise'] as int? ?? 0,
    sunset: json['sunset'] as int? ?? 0,
  );

  Map<String, dynamic> toMap() => {
    'type': type,
    'id': id,
    'country': country,
    'sunrise': sunrise,
    'sunset': sunset,
  };

  SysModel copyWith({
    int? type,
    int? id,
    String? country,
    int? sunrise,
    int? sunset,
  }) => SysModel(
    type: type ?? this.type,
    id: id ?? this.id,
    country: country ?? this.country,
    sunrise: sunrise ?? this.sunrise,
    sunset: sunset ?? this.sunset,
  );

  final int type;
  final int id;
  final String country;
  final int sunrise;
  final int sunset;
}
