part of 'favorites_cubit.dart';

enum FavoritesStatus {
  initial(),
  success(),
  failure(),
  loading();

  bool get isInitial => this == FavoritesStatus.initial;
  bool get isSuccess => this == FavoritesStatus.success;
  bool get isFailure => this == FavoritesStatus.failure;
  bool get isLoading => this == FavoritesStatus.loading;
}

class FavoritesState extends Equatable {
  const FavoritesState({
    required this.favorites,
    required this.status,
    required this.failure,
  });

  FavoritesState.initial()
    : favorites = [],
      status = FavoritesStatus.initial,
      failure = Failure.empty();

  final List<Favorite> favorites;
  final FavoritesStatus status;
  final Failure failure;

  FavoritesState copyWith({
    List<Favorite>? favorites,
    Failure? failure,
    FavoritesStatus? status,
  }) {
    return FavoritesState(
      favorites: favorites ?? this.favorites,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }

  @override
  List<Object> get props => [favorites, status, failure];
}
