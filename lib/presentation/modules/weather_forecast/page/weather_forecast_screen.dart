import 'package:climora/domain/entities/weather_forecast.dart';
import 'package:climora/presentation/modules/weather_forecast/cubit/weather_forecast_cubit.dart';
import 'package:climora/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherForecastScreen extends StatelessWidget {
  const WeatherForecastScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherForecastCubit, WeatherForecastState>(
      builder: (context, state) {
        return Scaffold(
          appBar: CustomAppbar(
            title: state.locationName.isEmpty ? 'Forecast' : state.locationName,
          ),
          body: switch (state.status) {
            WeatherForecastStatus.loading => const LoadingPage(),
            WeatherForecastStatus.failure => _FailureView(
              failure: state.failure?.message ?? 'Unknown error',
            ),
            WeatherForecastStatus.success => _ForecastTabView(
              groupedForecasts: state.groupedForecasts,
            ),
            _ => const Center(
              child: Text('No data available'),
            ),
          },
        );
      },
    );
  }
}

class _ForecastTabView extends StatelessWidget {
  const _ForecastTabView({required this.groupedForecasts});

  final Map<String, List<ForecastItem>> groupedForecasts;

  @override
  Widget build(BuildContext context) {
    final dayKeys = groupedForecasts.keys.toList()..sort();

    if (dayKeys.isEmpty) {
      return const Center(
        child: Text('No forecasts available'),
      );
    }

    return DefaultTabController(
      length: dayKeys.length,
      child: Column(
        children: [
          TabBar(
            isScrollable: true,
            tabs: dayKeys.map((dayKey) {
              return Tab(
                text: context.read<WeatherForecastCubit>().formatDayKey(dayKey),
              );
            }).toList(),
          ),
          Expanded(
            child: TabBarView(
              children: dayKeys.map((dayKey) {
                final dayForecasts = groupedForecasts[dayKey]!;
                return _DayForecastView(
                  dayKey: dayKey,
                  forecasts: dayForecasts,
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _DayForecastView extends StatelessWidget {
  const _DayForecastView({
    required this.dayKey,
    required this.forecasts,
  });

  final String dayKey;
  final List<ForecastItem> forecasts;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: forecasts.length,
      itemBuilder: (context, index) {
        final forecast = forecasts[index];
        return _ForecastItemCard(forecast: forecast);
      },
    );
  }
}

class _ForecastItemCard extends StatelessWidget {
  const _ForecastItemCard({required this.forecast});

  final ForecastItem forecast;

  @override
  Widget build(BuildContext context) {
    final dateTime = DateTime.parse(forecast.dtTxt);
    final hour = dateTime.hour;
    final temp = (forecast.main.temp - 273.15).round();
    final weatherInfo = forecast.weather.isNotEmpty
        ? forecast.weather.first
        : null;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Time
            SizedBox(
              width: 60,
              child: Text(
                '${hour.toString().padLeft(2, '0')}:00',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 16),

            // Weather icon placeholder (you can add actual weather icons here)
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: _getWeatherColor(weatherInfo?.main ?? ''),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                _getWeatherIcon(weatherInfo?.main ?? ''),
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),

            // Weather description and temperature
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$temp°C',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (weatherInfo != null)
                    Text(
                      weatherInfo.description,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                ],
              ),
            ),

            // Additional info
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.water_drop, size: 16, color: Colors.blue),
                    const SizedBox(width: 4),
                    Text('${forecast.main.humidity}%'),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.air, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text('${forecast.wind.speed.toStringAsFixed(1)} m/s'),
                  ],
                ),
                if (forecast.pop > 0) ...[
                  const SizedBox(height: 4),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.grain,
                        size: 16,
                        color: Colors.lightBlue,
                      ),
                      const SizedBox(width: 4),
                      Text('${(forecast.pop * 100).round()}%'),
                    ],
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getWeatherColor(String weatherMain) {
    switch (weatherMain.toLowerCase()) {
      case 'clear':
        return Colors.orange;
      case 'clouds':
        return Colors.grey;
      case 'rain':
        return Colors.blue;
      case 'drizzle':
        return Colors.lightBlue;
      case 'thunderstorm':
        return Colors.purple;
      case 'snow':
        return Colors.lightBlue.shade100;
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
      case 'sand':
      case 'ash':
      case 'squall':
      case 'tornado':
        return Colors.grey.shade400;
      default:
        return Colors.grey;
    }
  }

  IconData _getWeatherIcon(String weatherMain) {
    switch (weatherMain.toLowerCase()) {
      case 'clear':
        return Icons.wb_sunny;
      case 'clouds':
        return Icons.cloud;
      case 'rain':
        return Icons.water_drop;
      case 'drizzle':
        return Icons.grain;
      case 'thunderstorm':
        return Icons.flash_on;
      case 'snow':
        return Icons.ac_unit;
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
      case 'sand':
      case 'ash':
      case 'squall':
      case 'tornado':
        return Icons.foggy;
      default:
        return Icons.help_outline;
    }
  }
}

class _FailureView extends StatelessWidget {
  const _FailureView({required this.failure});

  final String failure;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 24),
            const Text(
              'Error',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              failure,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Volver'),
            ),
          ],
        ),
      ),
    );
  }
}
