import 'package:climora/domain/repositories/weather_repository.dart';
import 'package:climora/injection_container.dart';
import 'package:climora/presentation/modules/weather_forecast/cubit/weather_forecast_cubit.dart';
import 'package:climora/presentation/modules/weather_forecast/page/weather_forecast_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherForecastPage extends StatelessWidget {
  const WeatherForecastPage({
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
    return BlocProvider(
      create: (context) =>
          WeatherForecastCubit(repository: sl<WeatherRepository>())
            ..loadForecast(
              lat: lat,
              lon: lon,
              locationName: locationName,
            ),
      child: const WeatherForecastScreen(),
    );
  }
}
