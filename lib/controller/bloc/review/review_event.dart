part of 'review_bloc.dart';

sealed class ReviewEvent extends Equatable {}

final class ReviewPosted extends ReviewEvent {
  ReviewPosted(this.review) : super();

  final UserReview review;

  @override
  List<Object?> get props => [review];
}
