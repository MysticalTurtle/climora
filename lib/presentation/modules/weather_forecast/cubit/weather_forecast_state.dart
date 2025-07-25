part of 'weather_forecast_cubit.dart';

enum WeatherForecastStatus {
  initial,
  loading,
  success,
  failure;

  bool get isInitial => this == WeatherForecastStatus.initial;
  bool get isLoading => this == WeatherForecastStatus.loading;
  bool get isSuccess => this == WeatherForecastStatus.success;
  bool get isFailure => this == WeatherForecastStatus.failure;
}

class WeatherForecastState extends Equatable {
  const WeatherForecastState({
    required this.status,
    required this.groupedForecasts,
    required this.locationName,
    this.forecast,
    this.failure,
  });

  const WeatherForecastState.initial()
    : status = WeatherForecastStatus.initial,
      forecast = null,
      groupedForecasts = const {},
      locationName = '',
      failure = null;

  final WeatherForecastStatus status;
  final WeatherForecast? forecast;
  final Map<String, List<ForecastItem>> groupedForecasts;
  final String locationName;
  final Failure? failure;

  WeatherForecastState copyWith({
    WeatherForecastStatus? status,
    WeatherForecast? forecast,
    Map<String, List<ForecastItem>>? groupedForecasts,
    String? locationName,
    Failure? failure,
  }) {
    return WeatherForecastState(
      status: status ?? this.status,
      forecast: forecast ?? this.forecast,
      groupedForecasts: groupedForecasts ?? this.groupedForecasts,
      locationName: locationName ?? this.locationName,
      failure: failure ?? this.failure,
    );
  }

  @override
  List<Object?> get props => [
    status,
    forecast,
    groupedForecasts,
    locationName,
    failure,
  ];
}
