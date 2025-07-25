import 'package:climora/domain/domain.dart';
import 'package:flutter/material.dart';

class WeatherCard extends StatelessWidget {
  const WeatherCard({required this.weather, super.key});

  final Weather weather;

  @override
  Widget build(BuildContext context) {
    final temp = (weather.main.temp - 273.15).round();
    final weatherInfo = weather.weather.isNotEmpty
        ? weather.weather.first
        : null;

    final feelsLike = (weather.main.feelsLike - 273.15).round();
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Text(
              '$temp°C',
              style: const TextStyle(
                fontSize: 64,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (weatherInfo != null) ...[
              Text(
                weatherInfo.description.toUpperCase(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Sensación térmica: $feelsLike°C',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
