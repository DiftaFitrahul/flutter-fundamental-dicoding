part of 'restaurant_bloc.dart';

enum RestaurantStatus { initial, loading, success, failure }

final class RestaurantState extends Equatable {
  const RestaurantState(
      {this.restaurants = const <Restaurant>[],
      this.status = RestaurantStatus.initial,
      this.responseMessage = 'initial'});

  final List<Restaurant> restaurants;
  final RestaurantStatus status;
  final String responseMessage;

  RestaurantState copyWith(
      {List<Restaurant>? restaurants,
      RestaurantStatus? status,
      String? responseMessage}) {
    return RestaurantState(
      restaurants: restaurants ?? this.restaurants,
      status: status ?? this.status,
      responseMessage: responseMessage ?? this.responseMessage,
    );
  }

  @override
  List<Object?> get props => [restaurants, status, responseMessage];
}
