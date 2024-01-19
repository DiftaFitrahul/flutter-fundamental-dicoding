import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../controller/bloc/detail_restaurant/detail_restaurant.dart';
import '../../../controller/bloc/favorite/favorites.dart';
import '../../../data/model/restaurant.dart';

class HeaderNavigation extends StatelessWidget {
  const HeaderNavigation(
      {super.key,
      required this.detailRestaurant,
      this.isFavoriteButtonDisplayed = true});
  final DetailRestaurant detailRestaurant;
  final bool isFavoriteButtonDisplayed;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const Alignment(0, -0.87),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  elevation: 4,
                  minimumSize: Size.zero,
                  padding: const EdgeInsets.all(7),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: const Icon(
                  Icons.keyboard_arrow_left_sharp,
                  color: Colors.black,
                )),
            BlocListener<FavoritesBloc, FavoritesState>(
              listenWhen: (previous, current) => previous != current,
              listener: (context, state) {
                if (state.changeFavoriteStatus) {
                  context.read<DetailRestaurantBloc>().add(
                      DetailRestaurantIsFavoriteChanged(
                          isFavorite: !detailRestaurant.isFavorite));
                }
              },
              child: isFavoriteButtonDisplayed
                  ? ElevatedButton(
                      onPressed: () {
                        detailRestaurant.isFavorite
                            ? context
                                .read<FavoritesBloc>()
                                .add(FavoriteRemoved(id: detailRestaurant.id))
                            : context.read<FavoritesBloc>().add(FavoriteAdded(
                                restaurant: Restaurant(
                                    id: detailRestaurant.id,
                                    name: detailRestaurant.name,
                                    description: detailRestaurant.description,
                                    pictureId: detailRestaurant.pictureId,
                                    city: detailRestaurant.city,
                                    rating: detailRestaurant.rating)));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        elevation: 4,
                        minimumSize: Size.zero,
                        padding: const EdgeInsets.all(7),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      child: detailRestaurant.isFavorite
                          ? const Icon(
                              Icons.star,
                              color: Colors.amber,
                            )
                          : const Icon(
                              Icons.star_border,
                              color: Colors.black,
                            ))
                  : const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
