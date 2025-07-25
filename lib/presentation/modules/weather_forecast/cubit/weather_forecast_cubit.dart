import 'package:bloc/bloc.dart';
import 'package:climora/core/error/failure.dart';
import 'package:climora/domain/entities/weather_forecast.dart';
import 'package:climora/domain/repositories/weather_repository.dart';
import 'package:equatable/equatable.dart';

part 'weather_forecast_state.dart';

class WeatherForecastCubit extends Cubit<WeatherForecastState> {
  WeatherForecastCubit({required this.repository})
    : super(const WeatherForecastState.initial());

  final WeatherRepository repository;

  Future<void> loadForecast({
    required double lat,
    required double lon,
    required String locationName,
  }) async {
    emit(state.copyWith(status: WeatherForecastStatus.loading));

    final (failure, forecast) = await repository.getWeatherForecast(
      lat: lat,
      lon: lon,
    );

    if (failure != null) {
      emit(
        state.copyWith(
          status: WeatherForecastStatus.failure,
          failure: failure,
        ),
      );
      return;
    }

    if (forecast != null) {
      // Group forecast items by day
      final groupedForecasts = _groupForecastsByDay(forecast.list);

      emit(
        state.copyWith(
          status: WeatherForecastStatus.success,
          forecast: forecast,
          groupedForecasts: groupedForecasts,
          locationName: locationName,
        ),
      );
    }
  }

  Map<String, List<ForecastItem>> _groupForecastsByDay(
    List<ForecastItem> forecasts,
  ) {
    final grouped = <String, List<ForecastItem>>{};

    for (final forecast in forecasts) {
      // Parse the date from dt_txt (e.g., "2025-07-24 18:00:00")
      final dateTime = DateTime.parse(forecast.dtTxt);
      final dayKey =
          '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}'
          '-${dateTime.day.toString().padLeft(2, '0')}';

      if (!grouped.containsKey(dayKey)) {
        grouped[dayKey] = [];
      }
      grouped[dayKey]!.add(forecast);
    }

    return grouped;
  }

  String formatDayKey(String dayKey) {
    final date = DateTime.parse(dayKey);
    final now = DateTime.now();
    final tomorrow = now.add(const Duration(days: 1));

    if (date.day == now.day &&
        date.month == now.month &&
        date.year == now.year) {
      return 'Today';
    } else if (date.day == tomorrow.day &&
        date.month == tomorrow.month &&
        date.year == tomorrow.year) {
      return 'Tomorrow';
    } else {
      final weekdays = ['Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb', 'Dom'];
      final months = [
        'Ene',
        'Feb',
        'Mar',
        'Abr',
        'May',
        'Jun',
        'Jul',
        'Ago',
        'Sep',
        'Oct',
        'Nov',
        'Dic',
      ];
      return '${weekdays[date.weekday - 1]} ${date.day}'
          ' ${months[date.month - 1]}';
    }
  }
}
