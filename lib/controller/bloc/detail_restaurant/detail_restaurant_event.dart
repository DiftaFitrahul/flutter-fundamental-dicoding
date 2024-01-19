part of 'detail_restaurant_bloc.dart';

sealed class DetailRestaurantEvent extends Equatable {}

final class DetailRestaurantFetched extends DetailRestaurantEvent {
  DetailRestaurantFetched(
      {required this.restaurantId, required this.favoriteRestaurants})
      : super();

  final String restaurantId;
  final List<Restaurant> favoriteRestaurants;

  @override
  List<Object?> get props => [restaurantId];
}

final class DetailRestaurantReviewsChanged extends DetailRestaurantEvent {
  DetailRestaurantReviewsChanged({required this.reviews}) : super();

  final List<CustomerReview> reviews;

  @override
  List<Object?> get props => [reviews];
}

final class DetailRestaurantIsFavoriteChanged extends DetailRestaurantEvent {
  DetailRestaurantIsFavoriteChanged({required this.isFavorite}) : super();

  final bool isFavorite;

  @override
  List<Object?> get props => [isFavorite];
}
