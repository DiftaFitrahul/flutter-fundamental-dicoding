part of 'favorites_bloc.dart';

sealed class FavoritesEvent {}

final class FavoritesFetched extends FavoritesEvent {}

final class FavoriteAdded extends FavoritesEvent {
  FavoriteAdded({required this.restaurant});

  final Restaurant restaurant;
}

final class FavoriteRemoved extends FavoritesEvent {
  FavoriteRemoved({required this.id});
  final String id;
}
