class Weather {
  const Weather({
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

  factory Weather.fromMap(Map<String, dynamic> json) => Weather(
    coord: Coord.fromMap(json['coord'] as Map<String, dynamic>? ?? {}),
    weather: List<WeatherInfo>.from(
      (json['weather'] as List? ?? []).map(
        (x) => WeatherInfo.fromMap(x as Map<String, dynamic>),
      ),
    ),
    base: json['base'] as String? ?? '',
    main: Main.fromMap(json['main'] as Map<String, dynamic>? ?? {}),
    visibility: json['visibility'] as int? ?? 0,
    wind: Wind.fromMap(json['wind'] as Map<String, dynamic>? ?? {}),
    clouds: Clouds.fromMap(json['clouds'] as Map<String, dynamic>? ?? {}),
    dt: json['dt'] as int? ?? 0,
    sys: Sys.fromMap(json['sys'] as Map<String, dynamic>? ?? {}),
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

  Weather copyWith({
    Coord? coord,
    List<WeatherInfo>? weather,
    String? base,
    Main? main,
    int? visibility,
    Wind? wind,
    Clouds? clouds,
    int? dt,
    Sys? sys,
    int? timezone,
    int? id,
    String? name,
    int? cod,
  }) => Weather(
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

  final Coord coord;
  final List<WeatherInfo> weather;
  final String base;
  final Main main;
  final int visibility;
  final Wind wind;
  final Clouds clouds;
  final int dt;
  final Sys sys;
  final int timezone;
  final int id;
  final String name;
  final int cod;
}

class Coord {
  const Coord({
    required this.lon,
    required this.lat,
  });

  factory Coord.fromMap(Map<String, dynamic> json) => Coord(
    lon: (json['lon'] as num?)?.toDouble() ?? 0.0,
    lat: (json['lat'] as num?)?.toDouble() ?? 0.0,
  );

  Map<String, dynamic> toMap() => {
    'lon': lon,
    'lat': lat,
  };

  Coord copyWith({
    double? lon,
    double? lat,
  }) => Coord(
    lon: lon ?? this.lon,
    lat: lat ?? this.lat,
  );

  final double lon;
  final double lat;
}

class WeatherInfo {
  const WeatherInfo({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  factory WeatherInfo.fromMap(Map<String, dynamic> json) => WeatherInfo(
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

  WeatherInfo copyWith({
    int? id,
    String? main,
    String? description,
    String? icon,
  }) => WeatherInfo(
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

class Main {
  const Main({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
    required this.seaLevel,
    required this.grndLevel,
  });

  factory Main.fromMap(Map<String, dynamic> json) => Main(
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

  Main copyWith({
    double? temp,
    double? feelsLike,
    double? tempMin,
    double? tempMax,
    int? pressure,
    int? humidity,
    int? seaLevel,
    int? grndLevel,
  }) => Main(
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

class Wind {
  const Wind({
    required this.speed,
    required this.deg,
  });

  factory Wind.fromMap(Map<String, dynamic> json) => Wind(
    speed: (json['speed'] as num?)?.toDouble() ?? 0.0,
    deg: json['deg'] as int? ?? 0,
  );

  Map<String, dynamic> toMap() => {
    'speed': speed,
    'deg': deg,
  };

  Wind copyWith({
    double? speed,
    int? deg,
  }) => Wind(
    speed: speed ?? this.speed,
    deg: deg ?? this.deg,
  );

  final double speed;
  final int deg;
}

class Clouds {
  const Clouds({
    required this.all,
  });

  factory Clouds.fromMap(Map<String, dynamic> json) => Clouds(
    all: json['all'] as int? ?? 0,
  );

  Map<String, dynamic> toMap() => {
    'all': all,
  };

  Clouds copyWith({
    int? all,
  }) => Clouds(
    all: all ?? this.all,
  );

  final int all;
}

class Sys {
  const Sys({
    required this.type,
    required this.id,
    required this.country,
    required this.sunrise,
    required this.sunset,
  });

  factory Sys.fromMap(Map<String, dynamic> json) => Sys(
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

  Sys copyWith({
    int? type,
    int? id,
    String? country,
    int? sunrise,
    int? sunset,
  }) => Sys(
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
