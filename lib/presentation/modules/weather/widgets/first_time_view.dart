import 'package:climora/domain/entities/geocoding.dart';
import 'package:climora/presentation/modules/search/page/search_page.dart';
import 'package:climora/presentation/modules/weather/cubit/weather_cubit.dart';
import 'package:climora/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class FirstTimeView extends StatelessWidget {
  const FirstTimeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(title: 'Climora'),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight:
                  MediaQuery.of(context).size.height -
                  kToolbarHeight -
                  MediaQuery.of(context).padding.top -
                  MediaQuery.of(context).padding.bottom -
                  48, // padding
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  'assets/lottie/sunny.json',
                  width: 150,
                  height: 150,
                ),
                const SizedBox(height: 32),
                const Text(
                  'Welcome to Climora!',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Get updated weather information',
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
                    onPressed: () {
                      context.read<WeatherCubit>().getCurrentLocation();
                    },
                    icon: const Icon(Icons.my_location),
                    label: const Text('Use my current location'),
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
                        await context
                            .read<WeatherCubit>()
                            .loadWeatherForLocation(
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
