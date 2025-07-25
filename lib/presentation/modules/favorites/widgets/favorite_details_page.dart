import 'package:climora/domain/entities/geocoding.dart';
import 'package:climora/presentation/modules/favorites/cubit/favorites_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteDetailsPage extends StatelessWidget {
  const FavoriteDetailsPage({
    required this.location,
    super.key,
  });

  final GeocodingLocation location;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(location.name),
        elevation: 4,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero(
            //   tag: 'fav${location.lat},${location.lon}',
            //   child: CachedNetworkImage(
            //     imageUrl: location.image,
            //     fit: BoxFit.cover,
            //     height: 300,
            //     width: double.infinity,
            //     placeholder: (context, url) => Container(
            //       height: 300,
            //       color: Colors.grey.shade300,
            //       child: const Center(child: CircularProgressIndicator()),
            //     ),
            //     errorWidget: (context, url, error) =>
            //         const Icon(Icons.error, size: 100, color: Colors.red),
            //   ),
            // ),
            const SizedBox(height: 20),
            Text(
              location.name,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 10),
            InfoItem(title: 'Nombre:', value: location.name),
          ],
        ),
      ),
      floatingActionButton: BlocBuilder<FavoritesCubit, FavoritesState>(
        builder: (context, state) {
          final isFavorite = state.favorites.any(
            (element) => element.location == location,
          );
          return FloatingActionButton(
            backgroundColor: isFavorite ? Colors.red : Colors.grey,
            onPressed: () {
              // if (isFavorite) {
              //   context.read<FavoritesCubit>().removeFavorite(location);
              // } else {
              //   context.read<FavoritesCubit>().addFavorite(location);
              // }
            },
            child: const Icon(Icons.favorite, color: Colors.white),
          );
        },
      ),
    );
  }
}

class InfoItem extends StatelessWidget {
  const InfoItem({required this.title, required this.value, super.key});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
