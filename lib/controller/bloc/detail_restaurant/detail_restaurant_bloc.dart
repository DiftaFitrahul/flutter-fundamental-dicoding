import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/restaurant.dart';
import '../../../data/model/review.dart';
import '../../../data/repository/restaurant_api_service.dart';

part 'detail_restaurant_state.dart';
part 'detail_restaurant_event.dart';

class DetailRestaurantBloc
    extends Bloc<DetailRestaurantEvent, DetailRestaurantState> {
  DetailRestaurantBloc({required RestaurantAPIService restaurantAPIService})
      : _restaurantAPIService = restaurantAPIService,
        super(DetailRestaurantInitial()) {
    on<DetailRestaurantFetched>(_onDetailRestaurantFetched);
    on<DetailRestaurantReviewsChanged>(_onDetailRestaurantReviewsChanged);
    on<DetailRestaurantIsFavoriteChanged>(_onDetailRestaurantIsFavoriteChanged);
  }

  final RestaurantAPIService _restaurantAPIService;

  void _onDetailRestaurantReviewsChanged(DetailRestaurantReviewsChanged event,
      Emitter<DetailRestaurantState> emit) {
    emit(DetailRestaurantChangeCompleted(
        detailRestaurant:
            state.detailRestaurant.copyWith(customerReviews: event.reviews)));
  }

  void _onDetailRestaurantIsFavoriteChanged(
      DetailRestaurantIsFavoriteChanged event,
      Emitter<DetailRestaurantState> emit) {
    emit(DetailRestaurantChangeCompleted(
        detailRestaurant:
            state.detailRestaurant.copyWith(isFavorite: event.isFavorite)));
  }

  Future<void> _onDetailRestaurantFetched(DetailRestaurantFetched event,
      Emitter<DetailRestaurantState> emit) async {
    try {
      emit(DetailRestaurantLoading());

      DetailRestaurant result = await _restaurantAPIService.getDetailRestaurant(
          id: event.restaurantId);

      final isFavoriteRestaurant = event.favoriteRestaurants.any(
        (restaurant) => event.restaurantId == restaurant.id,
      );

      result = result.copyWith(isFavorite: isFavoriteRestaurant);

      emit(DetailRestaurantCompleted(detailRestaurant: result));
    } catch (err) {
      String errMessage = err.toString().contains('Failed host lookup')
          ? 'error connection'
          : err.toString();
      emit(
        DetailRestaurantError(message: errMessage),
      );
    }
  }
}
