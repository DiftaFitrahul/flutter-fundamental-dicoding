import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../controller/bloc/detail_restaurant/detail_restaurant.dart';
import '../../../controller/bloc/review/review.dart';
import '../../../data/model/review.dart';

class AddReviewBox extends StatefulWidget {
  const AddReviewBox({super.key, required this.id});

  final String id;
  @override
  State<AddReviewBox> createState() => _AddReviewBoxState();
}

class _AddReviewBoxState extends State<AddReviewBox> {
  late TextEditingController _nameController;
  late TextEditingController _reviewController;
  bool filledForm = true;

  @override
  void initState() {
    _nameController = TextEditingController();
    _reviewController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Add Review',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.black87,
                letterSpacing: 0,
              ),
        ),
        const SizedBox(height: 5),
        TextField(
          controller: _nameController,
          decoration: InputDecoration(
              hintText: 'name',
              fillColor: Colors.white,
              filled: true,
              errorText: filledForm ? null : 'form must be filled',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
          onTapOutside: (event) {
            FocusScope.of(context).unfocus();
          },
        ),
        const SizedBox(height: 5),
        TextField(
          controller: _reviewController,
          maxLines: 3,
          onTapOutside: (event) {
            FocusScope.of(context).unfocus();
          },
          decoration: InputDecoration(
              hintText: 'Review',
              fillColor: Colors.white,
              filled: true,
              errorText: filledForm ? null : 'form must be filled',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
        ),
        const SizedBox(height: 8),
        Align(
            alignment: Alignment.centerRight,
            child: BlocConsumer<ReviewBloc, ReviewState>(
              listenWhen: (previous, current) {
                if (current.status == ReviewStatus.success ||
                    current.status == ReviewStatus.failure) return true;
                return false;
              },
              listener: (context, state) {
                if (state.status == ReviewStatus.success) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.green[900],
                      content: const Text('Succes add review')));
                  BlocProvider.of<DetailRestaurantBloc>(context).add(
                      DetailRestaurantReviewsChanged(reviews: state.reviews));
                }

                if (state.status == ReviewStatus.failure) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.red[900],
                      content: Text(state.message)));
                }
              },
              builder: (context, state) {
                switch (state.status) {
                  case ReviewStatus.initial ||
                        ReviewStatus.success ||
                        ReviewStatus.failure:
                    return ElevatedButton(
                        onPressed: () {
                          setState(() {
                            if (_nameController.text.isNotEmpty &&
                                _reviewController.text.isNotEmpty) {
                              filledForm = true;
                              context.read<ReviewBloc>().add(ReviewPosted(
                                  UserReview(
                                      id: widget.id,
                                      name: _nameController.text,
                                      review: _reviewController.text)));
                            } else {
                              filledForm = false;
                            }
                          });
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8))),
                        child: const Text('post'));
                  case ReviewStatus.loading:
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: LoadingAnimationWidget.prograssiveDots(
                          color: Colors.amber, size: 55),
                    );
                }
              },
            ))
      ],
    );
  }
}
