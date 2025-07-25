import 'package:climora/core/core.dart';
import 'package:climora/presentation/modules/favorites/cubit/favorites_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesFailureView extends StatelessWidget {
  const FavoritesFailureView({required this.failure, super.key});

  final Failure failure;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(failure.message ?? 'Unknown error'),
          ElevatedButton(
            onPressed: () => context.read<FavoritesCubit>().init(),
            child: const Text('Try again'),
          ),
        ],
      ),
    );
  }
}
