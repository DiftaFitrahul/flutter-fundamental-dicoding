import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../controller/bloc/restaurant/restaurant.dart';
import '../../widget/home/item.dart';
import '../restaurant_shimmer.dart';
import '../error_message.dart';

class ListRestaurantItem extends StatelessWidget {
  const ListRestaurantItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(child: BlocBuilder<RestaurantBloc, RestaurantState>(
      builder: (context, state) {
        switch (state.status) {
          case RestaurantStatus.initial || RestaurantStatus.loading:
            return ListView.builder(
              itemCount: 10,
              itemBuilder: (_, __) => const RestaurantShimmerEffect(),
            );
          case RestaurantStatus.success:
            return ListView.builder(
              itemCount: state.restaurants.length,
              itemBuilder: (_, index) =>
                  RestaurantItem(item: state.restaurants[index]),
            );
          case RestaurantStatus.failure:
            return errorMessage(state.responseMessage);
        }
      },
    ));
  }
}
