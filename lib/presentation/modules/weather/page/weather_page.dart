import 'package:climora/core/core.dart';
import 'package:climora/domain/domain.dart';
import 'package:climora/injection_container.dart';
import 'package:climora/presentation/modules/weather/cubit/weather_cubit.dart';
import 'package:climora/presentation/modules/weather/widgets/widgets.dart';
import 'package:climora/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({this.initialLocation, super.key});

  final GeocodingLocation? initialLocation;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherCubit(
        repository: sl<WeatherRepository>(),
        locationService: sl<LocationService>(),
      )..init(initialLocation: initialLocation),
      child: BlocBuilder<WeatherCubit, WeatherState>(
        builder: (context, state) {
          return switch (state.status) {
            WeatherStatus.firstTime => const FirstTimeView(),
            WeatherStatus.loadingLocation => const LoadingLocationView(),
            WeatherStatus.loadingWeather => const LoadingPage(),
            WeatherStatus.hasLocation => const WeatherDisplayView(),
            WeatherStatus.success => const WeatherDisplayView(),
            WeatherStatus.permissionDeniedForever =>
              const PermissionDeniedForeverView(),
            WeatherStatus.failure => FailureView(
              failure: state.failure?.message ?? 'Error desconocido',
            ),
          };
        },
      ),
    );
  }
}
