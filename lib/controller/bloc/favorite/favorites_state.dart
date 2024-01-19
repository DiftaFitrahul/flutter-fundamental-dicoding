part of 'favorites_bloc.dart';

enum FavoritesStatus { loading, hasData, noData, error }

final class FavoritesState extends Equatable {
  const FavoritesState(
      {this.status = FavoritesStatus.noData,
      this.restaurants = const <Restaurant>[],
      this.message = 'initial data',
      this.changeFavoriteStatus = false});

  final FavoritesStatus status;
  final List<Restaurant> restaurants;
  final String message;
  final bool changeFavoriteStatus;

  FavoritesState copyWith(
      {FavoritesStatus? status,
      List<Restaurant>? restaurants,
      bool? changeFavoriteStatus,
      String? message}) {
    return FavoritesState(
        status: status ?? this.status,
        restaurants: restaurants ?? this.restaurants,
        changeFavoriteStatus: changeFavoriteStatus ?? this.changeFavoriteStatus,
        message: message ?? this.message);
  }

  @override
  List<Object?> get props =>
      [status, restaurants, message, changeFavoriteStatus];
}
