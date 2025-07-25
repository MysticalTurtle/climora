import 'package:climora/presentation/modules/favorites/cubit/favorites_cubit.dart';
import 'package:climora/presentation/modules/favorites/widgets/favorite_item.dart';
import 'package:climora/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesSucessView extends StatelessWidget {
  const FavoritesSucessView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(
        title: 'Favorites',
      ),
      body: Center(
        child: BlocBuilder<FavoritesCubit, FavoritesState>(
          builder: (context, state) {
            if (state.favorites.isEmpty) {
              return const Text('No favorites');
            }
            return ListView.builder(
              itemCount: state.favorites.length,
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, index) {
                final location = state.favorites[index].location;
                return FavoriteItem(location: location);
              },
            );
          },
        ),
      ),
    );
  }
}
