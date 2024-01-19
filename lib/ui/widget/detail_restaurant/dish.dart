import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../data/model/dish.dart';
import '../../../constant/color.dart';

class DetailRestaurantDish extends StatelessWidget {
  final int index;
  final Dish dish;
  final int lengthDish;

  const DetailRestaurantDish(
      {super.key,
      required this.index,
      required this.dish,
      required this.lengthDish});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          right: index == lengthDish - 1 ? 0 : 15, bottom: 10, left: 5, top: 5),
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: 100,
          decoration: BoxDecoration(
              color: secondaryColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
              boxShadow: const []),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  child: CachedNetworkImage(
                    imageUrl:
                        'https://static.vecteezy.com/system/resources/thumbnails/025/028/422/small/a-big-breakfast-food-png.png',
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                    errorWidget: (_, __, ___) => const Icon(Icons.error),
                  )),
              const SizedBox(
                height: 2,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Text(dish.name,
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Colors.black87,
                        letterSpacing: 0)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
