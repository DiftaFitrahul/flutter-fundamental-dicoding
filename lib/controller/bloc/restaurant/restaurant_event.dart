part of 'restaurant_bloc.dart';

sealed class RestaurantEvent extends Equatable {
  const RestaurantEvent();

  @override
  List<Object?> get props => [];
}

final class ListRestaurantFetched extends RestaurantEvent {
  const ListRestaurantFetched();

  @override
  List<Object?> get props => [];
}

final class RestaurantSearched extends RestaurantEvent {
  const RestaurantSearched({required this.query});

  final String query;

  @override
  List<Object?> get props => [query];
}
