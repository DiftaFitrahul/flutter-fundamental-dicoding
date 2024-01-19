import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../data/model/restaurant.dart';

class DetailRestaurantBoxMainInfo extends StatelessWidget {
  final DetailRestaurant detailRestaurant;
  const DetailRestaurantBoxMainInfo(
      {super.key, required this.detailRestaurant});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const AlignmentDirectional(0, 1),
      child: Container(
        width: double.infinity,
        height: 130,
        margin: const EdgeInsets.symmetric(horizontal: 48),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 2),
              blurRadius: 6,
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              detailRestaurant.name,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                  fontSize: 17,
                  overflow: TextOverflow.ellipsis,
                  letterSpacing: 0),
            ),
            Text(
              detailRestaurant.city,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Colors.black54,
                  fontSize: 15,
                  letterSpacing: 0),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('(${detailRestaurant.rating.toString()})',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w300,
                        color: Colors.black,
                        fontSize: 11,
                        letterSpacing: 0)),
                const SizedBox(
                  width: 5,
                ),
                RatingBar.builder(
                  initialRating: detailRestaurant.rating,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  ignoreGestures: true,
                  itemCount: 5,
                  itemSize: 28,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
