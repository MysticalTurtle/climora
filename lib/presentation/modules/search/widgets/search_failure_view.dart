import 'package:climora/core/core.dart';
import 'package:climora/presentation/modules/search/cubit/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchFailureView extends StatelessWidget {
  const SearchFailureView({required this.failure, super.key});

  final Failure failure;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(failure.message ?? 'Error desconocido'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  final searchCubit = context.read<SearchCubit>();
                  searchCubit.searchLocations(searchCubit.state.query);
                },
                child: const Text('Try again'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
