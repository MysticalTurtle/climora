import 'package:climora/domain/entities/geocoding.dart';
import 'package:climora/presentation/modules/search/cubit/search_cubit.dart';
import 'package:climora/presentation/modules/search/widgets/search_bar.dart';
import 'package:climora/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchSucessView extends StatelessWidget {
  const SearchSucessView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<SearchCubit, SearchState>(
          builder: (context, state) {
            return Column(
              children: [
                AppSearchBar(
                  requestFocus: state.status.isInitial,
                ),
                Expanded(
                  child: state.status.isLoading
                      ? const LoadingPage()
                      : state.locations.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (state.status.isSuccess) ...[
                                const Icon(
                                  Icons.location_off,
                                  size: 64,
                                  color: Colors.grey,
                                ),
                                const SizedBox(height: 16),
                                const Text(
                                  'No locations found',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'Try with another search term',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ] else ...[
                                const Icon(
                                  Icons.search,
                                  size: 64,
                                  color: Colors.grey,
                                ),
                                const SizedBox(height: 16),
                                const Text(
                                  'Search for a location',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        )
                      : ListView.builder(
                          itemCount: state.locations.length,
                          padding: const EdgeInsets.all(16),
                          itemBuilder: (context, index) {
                            final location = state.locations[index];
                            return _LocationTile(
                              location: location,
                              onTap: () {
                                Navigator.of(context).pop(location);
                              },
                            );
                          },
                        ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _LocationTile extends StatelessWidget {
  const _LocationTile({
    required this.location,
    required this.onTap,
  });

  final GeocodingLocation location;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: const Icon(
          Icons.location_on,
          color: Colors.blue,
        ),
        title: Text(
          location.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (location.state != null) ...[
              Text('${location.state}, ${location.country}'),
            ] else ...[
              Text(location.country),
            ],
            const SizedBox(height: 4),
            Text(
              'Lat: ${location.lat.toStringAsFixed(4)}, '
              'Lon: ${location.lon.toStringAsFixed(4)}',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ],
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }
}
