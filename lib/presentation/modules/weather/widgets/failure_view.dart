import 'package:climora/domain/entities/geocoding.dart';
import 'package:climora/presentation/modules/search/page/search_page.dart';
import 'package:climora/presentation/modules/weather/cubit/weather_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FailureView extends StatelessWidget {
  const FailureView({required this.failure, super.key});

  final String failure;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Climora'),
        centerTitle: true,
      ),
      body: Center(
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
                  context.read<WeatherCubit>().checkInitialState();
                },
                child: const Text('Try again'),
              ),
              const SizedBox(height: 16),
              TextButton(
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
                child: const Text('Search location manually'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
