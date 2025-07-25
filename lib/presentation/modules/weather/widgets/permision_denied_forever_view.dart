import 'package:climora/domain/entities/geocoding.dart';
import 'package:climora/presentation/modules/search/page/search_page.dart';
import 'package:climora/presentation/modules/weather/cubit/weather_cubit.dart';
import 'package:climora/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

class PermissionDeniedForeverView extends StatelessWidget {
  const PermissionDeniedForeverView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(title: 'Climora'),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.location_disabled,
                size: 120,
                color: Colors.orange,
              ),
              const SizedBox(height: 32),
              const Text(
                'Location permissions required',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text(
                'To get weather for your current location, you need to '
                'enable location permissions in the app settings.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    context.read<WeatherCubit>().openAppSettings();
                    await Geolocator.openAppSettings();
                  },
                  icon: const Icon(Icons.settings),
                  label: const Text('Open settings'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () async {
                    final selectedLocation =
                        await Navigator.push<GeocodingLocation>(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SearchPage(),
                          ),
                        );

                    if (selectedLocation != null && context.mounted) {
                      await context.read<WeatherCubit>().loadWeatherForLocation(
                        selectedLocation,
                      );
                    }
                  },
                  icon: const Icon(Icons.search),
                  label: const Text('Search for a location'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  context.read<WeatherCubit>().retryLocationPermissions();
                },
                child: const Text('Verificar permisos nuevamente'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
