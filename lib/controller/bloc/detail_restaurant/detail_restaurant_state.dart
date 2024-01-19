part of 'detail_restaurant_bloc.dart';

sealed class DetailRestaurantState extends Equatable {
  const DetailRestaurantState(this.detailRestaurant);

  final DetailRestaurant detailRestaurant;

  @override
  List<Object?> get props => [detailRestaurant];
}

final class DetailRestaurantInitial extends DetailRestaurantState {
  DetailRestaurantInitial() : super(DetailRestaurant.empty);
}

final class DetailRestaurantLoading extends DetailRestaurantState {
  DetailRestaurantLoading() : super(DetailRestaurant.empty);
}

final class DetailRestaurantCompleted extends DetailRestaurantState {
  const DetailRestaurantCompleted({required DetailRestaurant detailRestaurant})
      : super(detailRestaurant);
}

final class DetailRestaurantChangeCompleted extends DetailRestaurantState {
  const DetailRestaurantChangeCompleted(
      {required DetailRestaurant detailRestaurant})
      : super(detailRestaurant);
}

final class DetailRestaurantError extends DetailRestaurantState {
  DetailRestaurantError({required this.message})
      : super(DetailRestaurant.empty);

  final String message;

  @override
  List<Object?> get props => [message];
}
