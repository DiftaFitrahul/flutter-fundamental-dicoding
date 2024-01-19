import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controller/bloc/restaurant/restaurant.dart';
import '../widget/home/android/search_bar.dart';
import '../widget/home/ios/search_bar.dart';
import '../widget/home/list_item.dart';
import '../widget/home/title.dart';
import '../widget/platform_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<RestaurantBloc>().add(const ListRestaurantFetched());
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
                  const SizedBox(
                    height: 30,
                  ),
                  const HomeTitle(),
                  const SizedBox(
                    height: 20,
                  ),
                  PlatformWidget(
                    androidBuilder: _androidSearchBarBuilder,
                    iosBuilder: _iosSearchBarBuilder,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const ListRestaurantItem()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _androidSearchBarBuilder(BuildContext context) {
    return const HomeAndroidSearchBar();
  }

  Widget _iosSearchBarBuilder(BuildContext context) {
    return const HomeIosSearchBar();
  }
}
