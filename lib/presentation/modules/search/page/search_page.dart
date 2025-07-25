import 'package:climora/domain/repositories/weather_repository.dart';
import 'package:climora/injection_container.dart';
import 'package:climora/presentation/modules/search/cubit/search_cubit.dart';
import 'package:climora/presentation/modules/search/page/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SearchCubit(repository: sl<WeatherRepository>())..clear(),
      child: const SearchScreen(),
    );
  }
}
