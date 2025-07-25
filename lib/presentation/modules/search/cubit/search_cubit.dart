import 'package:bloc/bloc.dart';
import 'package:climora/core/core.dart';
import 'package:climora/domain/entities/geocoding.dart';
import 'package:climora/domain/repositories/weather_repository.dart';
import 'package:equatable/equatable.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit({required this.repository}) : super(SearchState.initial());

  final WeatherRepository repository;

  Future<void> clear() async {
    emit(
      state.copyWith(
        status: SearchStatus.initial,
        locations: [],
        query: '',
      ),
    );
  }

  Future<void> searchLocations(String query) async {
    if (query.trim().isEmpty) {
      await clear();
      return;
    }

    emit(state.copyWith(status: SearchStatus.loading, query: query));

    final (failure, response) = await repository.searchLocations(
      query: query,
      limit: 10,
    );

    if (failure != null) {
      emit(
        state.copyWith(
          failure: failure,
          status: SearchStatus.failure,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        locations: response ?? [],
        status: SearchStatus.success,
      ),
    );
  }

  void selectLocation(GeocodingLocation location) {
    // This will be handled by the page that pops with the selected location
  }
}
