import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

import '../../../constant/api.dart';
import '../../../controller/bloc/favorite/favorites.dart';
import '../../../controller/bloc/detail_restaurant/detail_restaurant.dart';
import '../../../data/model/restaurant.dart';
import '../../../routes/routes_name.dart';

class RestaurantItem extends StatelessWidget {
  final Restaurant item;
  const RestaurantItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesBloc, FavoritesState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            context.read<DetailRestaurantBloc>().add(DetailRestaurantFetched(
                restaurantId: item.id, favoriteRestaurants: state.restaurants));

            context.pushNamed(RoutesName.detailRestaurant, extra: {
              "restaurantId": item.id,
              "favoriteRestaurants": state.restaurants
            });
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 0,
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              children: [
                Hero(
                  tag: item.id,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: '$baseImageURL/${item.pictureId}',
                        width: 120,
                        height: 100,
                        fit: BoxFit.cover,
                        placeholder: (_, __) => _shimmerEffect(),
                        errorWidget: (_, __, ___) => const Icon(Icons.error),
                      )),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              item.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(right: 10.0),
                            child: Icon(
                              Icons.arrow_forward_ios_sharp,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 15,
                            color: Colors.black38,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            item.city,
                            style: const TextStyle(
                              color: Colors.black38,
                              fontSize: 14,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            size: 15,
                            color: Colors.yellow[800],
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(item.rating.toString(),
                              style: Theme.of(context).textTheme.bodyMedium)
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget _shimmerEffect() {
  return Shimmer.fromColors(
    baseColor: Colors.grey.withOpacity(0.15),
    highlightColor: Colors.grey.withOpacity(0.25),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey,
      ),
      width: 150,
      height: 110,
    ),
  );
}
