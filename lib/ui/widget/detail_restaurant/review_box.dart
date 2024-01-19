import 'package:flutter/material.dart';

import '../../../data/model/review.dart';

class ReviewBox extends StatelessWidget {
  const ReviewBox({super.key, required this.review});

  final CustomerReview review;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.account_circle,
                    color: Color.fromARGB(255, 0, 62, 154),
                    size: 30,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.4,
                    child: Text(
                      review.name,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 14),
                    ),
                  ),
                ],
              ),
              Text(
                review.date,
                style: const TextStyle(fontSize: 11.5, color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            review.review,
            style: const TextStyle(fontSize: 13),
          )
        ],
      ),
    );
  }
}
