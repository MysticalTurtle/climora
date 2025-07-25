import 'package:climora/data/model/weather_model.dart';

class WeatherForecastModel {
  const WeatherForecastModel({
    required this.cod,
    required this.message,
    required this.cnt,
    required this.list,
    required this.city,
  });

  factory WeatherForecastModel.fromMap(Map<String, dynamic> json) =>
      WeatherForecastModel(
        cod: json['cod'] as String? ?? '',
        message: json['message'] as int? ?? 0,
        cnt: json['cnt'] as int? ?? 0,
        list: List<ForecastItemModel>.from(
          (json['list'] as List? ?? []).map(
            (x) => ForecastItemModel.fromMap(x as Map<String, dynamic>),
          ),
        ),
        city: CityModel.fromMap(json['city'] as Map<String, dynamic>? ?? {}),
      );

  Map<String, dynamic> toMap() => {
    'cod': cod,
    'message': message,
    'cnt': cnt,
    'list': List<dynamic>.from(list.map((x) => x.toMap())),
    'city': city.toMap(),
  };

  WeatherForecastModel copyWith({
    String? cod,
    int? message,
    int? cnt,
    List<ForecastItemModel>? list,
    CityModel? city,
  }) => WeatherForecastModel(
    cod: cod ?? this.cod,
    message: message ?? this.message,
    cnt: cnt ?? this.cnt,
    list: list ?? this.list,
    city: city ?? this.city,
  );

  final String cod;
  final int message;
  final int cnt;
  final List<ForecastItemModel> list;
  final CityModel city;
}

class ForecastItemModel {
  const ForecastItemModel({
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

  factory ForecastItemModel.fromMap(Map<String, dynamic> json) =>
      ForecastItemModel(
        dt: json['dt'] as int? ?? 0,
        main: ForecastMainModel.fromMap(
          json['main'] as Map<String, dynamic>? ?? {},
        ),
        weather: List<WeatherInfoModel>.from(
          (json['weather'] as List? ?? []).map(
            (x) => WeatherInfoModel.fromMap(x as Map<String, dynamic>),
          ),
        ),
        clouds: CloudsModel.fromMap(
          json['clouds'] as Map<String, dynamic>? ?? {},
        ),
        wind: ForecastWindModel.fromMap(
          json['wind'] as Map<String, dynamic>? ?? {},
        ),
        visibility: json['visibility'] as int? ?? 0,
        pop: (json['pop'] as num?)?.toDouble() ?? 0.0,
        sys: ForecastSysModel.fromMap(
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

  ForecastItemModel copyWith({
    int? dt,
    ForecastMainModel? main,
    List<WeatherInfoModel>? weather,
    CloudsModel? clouds,
    ForecastWindModel? wind,
    int? visibility,
    double? pop,
    ForecastSysModel? sys,
    String? dtTxt,
  }) => ForecastItemModel(
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
  final ForecastMainModel main;
  final List<WeatherInfoModel> weather;
  final CloudsModel clouds;
  final ForecastWindModel wind;
  final int visibility;
  final double pop;
  final ForecastSysModel sys;
  final String dtTxt;
}

class ForecastMainModel {
  const ForecastMainModel({
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

  factory ForecastMainModel.fromMap(Map<String, dynamic> json) =>
      ForecastMainModel(
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

  ForecastMainModel copyWith({
    double? temp,
    double? feelsLike,
    double? tempMin,
    double? tempMax,
    int? pressure,
    int? seaLevel,
    int? grndLevel,
    int? humidity,
    double? tempKf,
  }) => ForecastMainModel(
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

class ForecastWindModel {
  const ForecastWindModel({
    required this.speed,
    required this.deg,
    required this.gust,
  });

  factory ForecastWindModel.fromMap(Map<String, dynamic> json) =>
      ForecastWindModel(
        speed: (json['speed'] as num?)?.toDouble() ?? 0.0,
        deg: json['deg'] as int? ?? 0,
        gust: (json['gust'] as num?)?.toDouble() ?? 0.0,
      );

  Map<String, dynamic> toMap() => {
    'speed': speed,
    'deg': deg,
    'gust': gust,
  };

  ForecastWindModel copyWith({
    double? speed,
    int? deg,
    double? gust,
  }) => ForecastWindModel(
    speed: speed ?? this.speed,
    deg: deg ?? this.deg,
    gust: gust ?? this.gust,
  );

  final double speed;
  final int deg;
  final double gust;
}

class ForecastSysModel {
  const ForecastSysModel({
    required this.pod,
  });

  factory ForecastSysModel.fromMap(Map<String, dynamic> json) =>
      ForecastSysModel(
        pod: json['pod'] as String? ?? '',
      );

  Map<String, dynamic> toMap() => {
    'pod': pod,
  };

  ForecastSysModel copyWith({
    String? pod,
  }) => ForecastSysModel(
    pod: pod ?? this.pod,
  );

  final String pod;
}

class CityModel {
  const CityModel({
    required this.id,
    required this.name,
    required this.coord,
    required this.country,
    required this.population,
    required this.timezone,
    required this.sunrise,
    required this.sunset,
  });

  factory CityModel.fromMap(Map<String, dynamic> json) => CityModel(
    id: json['id'] as int? ?? 0,
    name: json['name'] as String? ?? '',
    coord: CoordModel.fromMap(
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

  CityModel copyWith({
    int? id,
    String? name,
    CoordModel? coord,
    String? country,
    int? population,
    int? timezone,
    int? sunrise,
    int? sunset,
  }) => CityModel(
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
  final CoordModel coord;
  final String country;
  final int population;
  final int timezone;
  final int sunrise;
  final int sunset;
}
