import 'package:flutter/material.dart';

import '../../../data/model/dish.dart';
import './dish.dart';

class DetailRestaurantListDish extends StatelessWidget {
  final List<Dish> dishes;
  const DetailRestaurantListDish({super.key, required this.dishes});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 165,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: dishes.length,
            itemBuilder: (context, index) => DetailRestaurantDish(
                  index: index,
                  dish: dishes[index],
                  lengthDish: dishes.length,
                )));
  }
}
