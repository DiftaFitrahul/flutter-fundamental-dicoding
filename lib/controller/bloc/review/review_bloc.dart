import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repository/restaurant_api_service.dart';
import '../../../data/model/review.dart';

part 'review_state.dart';
part 'review_event.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  ReviewBloc({required RestaurantAPIService restaurantAPIService})
      : _restaurantAPIService = restaurantAPIService,
        super(const ReviewState()) {
    on<ReviewPosted>(_onReviewPosted);
  }

  final RestaurantAPIService _restaurantAPIService;

  Future<void> _onReviewPosted(
      ReviewPosted event, Emitter<ReviewState> emit) async {
    try {
      emit(state.copyWith(status: ReviewStatus.loading));
      final result = await _restaurantAPIService.postRestaurantReview(
          review: event.review);
      emit(state.copyWith(
          status: ReviewStatus.success,
          message: 'success post review',
          reviews: result));
    } catch (err) {
      String errMessage = err.toString().contains('Failed host lookup')
          ? 'error connection'
          : err.toString();
      emit(state.copyWith(status: ReviewStatus.failure, message: errMessage));
    }
  }
}
