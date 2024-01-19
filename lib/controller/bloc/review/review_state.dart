part of 'review_bloc.dart';

enum ReviewStatus { initial, loading, success, failure }

final class ReviewState extends Equatable {
  const ReviewState({
    this.message = '',
    this.status = ReviewStatus.initial,
    this.reviews = const <CustomerReview>[],
  });

  final String message;
  final ReviewStatus status;
  final List<CustomerReview> reviews;

  ReviewState copyWith({
    String? message,
    ReviewStatus? status,
    List<CustomerReview>? reviews,
  }) {
    return ReviewState(
      message: message ?? this.message,
      status: status ?? this.status,
      reviews: reviews ?? this.reviews,
    );
  }

  @override
  List<Object?> get props => [message, status, reviews];
}
