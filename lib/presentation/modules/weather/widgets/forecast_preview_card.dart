import 'package:climora/presentation/modules/weather_forecast/page/weather_forecast_page.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ForecastPreviewCard extends StatelessWidget {
  const ForecastPreviewCard({
    required this.lat,
    required this.lon,
    required this.locationName,
    super.key,
  });

  final double lat;
  final double lon;
  final String locationName;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (context) => WeatherForecastPage(
                lat: lat,
                lon: lon,
                locationName: locationName,
              ),
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Lottie.asset(
                'assets/lottie/weather.json',
                width: 50,
                height: 50,
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Extended forecast',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'View hourly and daily forecast',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
