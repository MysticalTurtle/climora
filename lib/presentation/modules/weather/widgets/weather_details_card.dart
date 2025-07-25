import 'package:climora/domain/domain.dart';
import 'package:flutter/material.dart';

class WeatherDetailsCard extends StatelessWidget {
  const WeatherDetailsCard({required this.weather, super.key});

  final Weather weather;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Details',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _DetailRow(
              icon: Icons.thermostat,
              label: 'Temperature',
              value:
                  '${(weather.main.tempMin - 273.15).round()}° / ${(weather.main.tempMax - 273.15).round()}°',
            ),
            _DetailRow(
              icon: Icons.water_drop,
              label: 'Humidity',
              value: '${weather.main.humidity}%',
            ),
            _DetailRow(
              icon: Icons.speed,
              label: 'Pressure',
              value: '${weather.main.pressure} hPa',
            ),
            _DetailRow(
              icon: Icons.air,
              label: 'Wind',
              value: '${weather.wind.speed} m/s',
            ),
            _DetailRow(
              icon: Icons.visibility,
              label: 'Visibility',
              value: '${(weather.visibility / 1000).toStringAsFixed(1)} km',
            ),
            if (weather.clouds.all > 0)
              _DetailRow(
                icon: Icons.cloud,
                label: 'Cloudiness',
                value: '${weather.clouds.all}%',
              ),
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey[600]),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontSize: 14),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
