import 'package:climora/presentation/modules/favorites/cubit/favorites_cubit.dart';
import 'package:climora/presentation/modules/favorites/page/favorites_failure_view.dart';
import 'package:climora/presentation/modules/favorites/page/favorites_sucess_view.dart';
import 'package:climora/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesCubit, FavoritesState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        return switch (state.status) {
          (FavoritesStatus.failure) => FavoritesFailureView(
            failure: state.failure,
          ),
          (FavoritesStatus.loading) => const LoadingPage(),
          (_) => const FavoritesSucessView(),
        };
      },
    );
  }
}
