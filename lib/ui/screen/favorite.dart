import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../constant/assets_path.dart';
import '../../controller/bloc/favorite/favorites.dart';
import '../widget/error_message.dart';
import '../widget/home/item.dart';
import '../widget/restaurant_shimmer.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<FavoritesBloc>().add(FavoritesFetched());
      },
      color: Colors.amber,
      child: Stack(
        children: [
          ListView(),
          SafeArea(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                const SizedBox(height: 30),
                Text(
                  'Favorites',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(child: _listFavorites(context))
              ],
            ),
          ))
        ],
      ),
    );
  }

  Widget _listFavorites(BuildContext context) {
    return BlocBuilder<FavoritesBloc, FavoritesState>(
      builder: (context, state) {
        switch (state.status) {
          case FavoritesStatus.loading:
            return ListView.builder(
              itemCount: 10,
              itemBuilder: (_, __) => const RestaurantShimmerEffect(),
            );
          case FavoritesStatus.noData:
            return _emptyFavoritesWidge();
          case FavoritesStatus.hasData:
            return ListView.builder(
              itemCount: state.restaurants.length,
              itemBuilder: (_, index) =>
                  RestaurantItem(item: state.restaurants[index]),
            );
          case FavoritesStatus.error:
            return errorMessage(state.message);
        }
      },
    );
  }

  Widget _emptyFavoritesWidge() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(emptyAnimationPath, reverse: true),
          const SizedBox(
            height: 30,
          ),
          const Text(
            'Data Kosong',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Color.fromARGB(167, 158, 158, 158)),
          ),
        ],
      ),
    );
  }
}
