import 'package:climora/domain/domain.dart';
import 'package:climora/presentation/modules/favorites/cubit/favorites_cubit.dart';
import 'package:climora/presentation/modules/favorites/page/favorites_page.dart';
import 'package:climora/presentation/modules/search/page/search_page.dart';
import 'package:climora/presentation/modules/weather/cubit/weather_cubit.dart';
import 'package:climora/presentation/modules/weather/widgets/widgets.dart';
import 'package:climora/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherDisplayView extends StatelessWidget {
  const WeatherDisplayView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, state) {
        if (state.weather == null) {
          return const LoadingPage();
        }

        final weather = state.weather!;
        final location = state.savedLocation;

        return Scaffold(
          appBar: CustomAppbar(
            title:
                '${location?.name ?? weather.name} '
                '${location?.country ?? ''}',
            actions: [
              IconButton(
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
                icon: const Icon(Icons.search, color: Colors.white),
                tooltip: 'Search another location',
              ),
            ],
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              await context.read<WeatherCubit>().loadWeatherForSavedLocation();
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  WeatherCard(weather: weather),
                  const SizedBox(height: 16),
                  WeatherDetailsCard(weather: weather),
                  const SizedBox(height: 16),
                  ForecastPreviewCard(
                    lat: location?.lat ?? weather.coord.lat,
                    lon: location?.lon ?? weather.coord.lon,
                    locationName: location?.name ?? weather.name,
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push<void>(
                MaterialPageRoute(
                  builder: (_) => const FavoritesPage(),
                ),
              );
            },
            child: BlocBuilder<FavoritesCubit, FavoritesState>(
              builder: (context, favState) {
                final currentLocation =
                    location ??
                    GeocodingLocation(
                      name: weather.name,
                      localNames: const LocalNames(),
                      lat: weather.coord.lat,
                      lon: weather.coord.lon,
                      country: weather.sys.country,
                      state: '',
                    );

                final isFavorite = favState.favorites.any(
                  (favorite) =>
                      favorite.location.lat == currentLocation.lat &&
                      favorite.location.lon == currentLocation.lon,
                );

                return IconButton(
                  onPressed: () {
                    if (isFavorite) {
                      // Find the favorite to remove
                      final favoriteToRemove = favState.favorites.firstWhere(
                        (favorite) =>
                            favorite.location.lat == currentLocation.lat &&
                            favorite.location.lon == currentLocation.lon,
                      );
                      context.read<FavoritesCubit>().removeFavorite(
                        favoriteToRemove.id,
                      );
                      // Show snackbar
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            '${currentLocation.name} removed from favorites',
                          ),
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.primary,
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    } else {
                      context.read<FavoritesCubit>().addFavorite(
                        currentLocation,
                      );
                      // Show snackbar
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            '${currentLocation.name} added to favorites',
                          ),
                          backgroundColor: Colors.green,
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                  icon: Icon(
                    Icons.favorite,
                    color: isFavorite
                        ? Theme.of(context).colorScheme.primary
                        : Colors.white,
                  ),
                  tooltip: isFavorite
                      ? 'Remove from favorites'
                      : 'Add to favorites',
                );
              },
            ),
          ),
        );
      },
    );
  }
}
