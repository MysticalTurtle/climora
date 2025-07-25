part of 'search_cubit.dart';

enum SearchStatus {
  initial(),
  success(),
  failure(),
  loading();

  bool get isInitial => this == SearchStatus.initial;
  bool get isSuccess => this == SearchStatus.success;
  bool get isFailure => this == SearchStatus.failure;
  bool get isLoading => this == SearchStatus.loading;
}

class SearchState extends Equatable {
  const SearchState({
    required this.locations,
    required this.query,
    required this.status,
    required this.failure,
  });

  SearchState.initial()
    : locations = const <GeocodingLocation>[],
      query = '',
      status = SearchStatus.initial,
      failure = Failure.empty();

  final List<GeocodingLocation> locations;
  final String query;
  final SearchStatus status;
  final Failure failure;

  SearchState copyWith({
    List<GeocodingLocation>? locations,
    String? query,
    int? page,
    Failure? failure,
    SearchStatus? status,
  }) {
    return SearchState(
      locations: locations ?? this.locations,
      query: query ?? this.query,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }

  @override
  List<Object> get props => [locations, query, status, failure];
}
