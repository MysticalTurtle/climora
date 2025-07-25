import 'package:climora/presentation/modules/search/cubit/search_cubit.dart';
import 'package:climora/presentation/modules/search/widgets/search_failure_view.dart';
import 'package:climora/presentation/modules/search/widgets/search_sucess_view.dart';
import 'package:climora/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        return switch (state.status) {
          (SearchStatus.failure) => SearchFailureView(
            failure: state.failure,
          ),
          (SearchStatus.loading) => const LoadingPage(),
          (_) => const SearchSucessView(),
        };
      },
    );
  }
}
