import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

import '../../../data/model/restaurant.dart';

class DetailRestaurantDescription extends StatelessWidget {
  final DetailRestaurant detailRestaurant;
  const DetailRestaurantDescription(
      {super.key, required this.detailRestaurant});

  @override
  Widget build(BuildContext context) {
    return ReadMoreText(
      detailRestaurant.description,
      trimLines: 5,
      colorClickableText: Colors.red,
      trimMode: TrimMode.Line,
      trimCollapsedText: 'Show more',
      trimExpandedText: ' Show less',
      lessStyle: TextStyle(
          fontSize: 13, fontWeight: FontWeight.bold, color: Colors.blue[700]),
      moreStyle: TextStyle(
          fontSize: 13, fontWeight: FontWeight.bold, color: Colors.blue[700]),
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.w400,
          color: Colors.black87,
          fontSize: 15,
          letterSpacing: 0),
    );
  }
}
