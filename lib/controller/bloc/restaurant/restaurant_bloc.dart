import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/transformers.dart';

import '../../../data/repository/restaurant_api_service.dart';
import '../../../data/model/restaurant.dart';

part 'restaurant_event.dart';
part 'restaurant_state.dart';

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  RestaurantBloc({required RestaurantAPIService restaurantAPIService})
      : _restaurantAPIService = restaurantAPIService,
        super(const RestaurantState()) {
    on<ListRestaurantFetched>(_onListRestaurantFetched);
    on<RestaurantSearched>(_onRestaurantSearched,
        transformer: debounce(const Duration(milliseconds: 400)));
  }

  final RestaurantAPIService _restaurantAPIService;

  Future<void> _onListRestaurantFetched(
      ListRestaurantFetched event, Emitter<RestaurantState> emit) async {
    try {
      emit(state.copyWith(status: RestaurantStatus.loading));
      final result = await _restaurantAPIService.getListRestauran();
      emit(state.copyWith(
          status: RestaurantStatus.success,
          restaurants: result.restaurants,
          responseMessage: result.message));
    } catch (err) {
      String errMessage = err.toString().contains('Failed host lookup')
          ? 'error connection'
          : err.toString();
      emit(state.copyWith(
          status: RestaurantStatus.failure, responseMessage: errMessage));
    }
  }

  Future<void> _onRestaurantSearched(
      RestaurantSearched event, Emitter<RestaurantState> emit) async {
    try {
      emit(state.copyWith(status: RestaurantStatus.loading));
      final result =
          await _restaurantAPIService.searchRestaurant(query: event.query);
      emit(state.copyWith(
          status: RestaurantStatus.success,
          restaurants: result.restaurantt,
          responseMessage: 'Success'));
    } catch (err) {
      String errMessage = err.toString().contains('Failed host lookup')
          ? 'error connection'
          : err.toString();

      emit(state.copyWith(
          status: RestaurantStatus.failure, responseMessage: errMessage));
    }
  }
}
