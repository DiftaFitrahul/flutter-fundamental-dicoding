import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../constant/api.dart';
import '../../../data/model/restaurant.dart';

class DetailRestaurantTopImageBG extends StatelessWidget {
  final DetailRestaurant detailRestaurant;
  const DetailRestaurantTopImageBG({super.key, required this.detailRestaurant});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return ClipRRect(
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
        child: CachedNetworkImage(
          imageUrl: '$baseImageURL/${detailRestaurant.pictureId}',
          height: screenHeight * 0.38,
          fit: BoxFit.cover,
          errorWidget: (_, __, ___) => const Icon(Icons.error),
        ));
  }
}
