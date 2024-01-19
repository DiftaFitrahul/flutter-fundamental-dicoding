import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controller/bloc/detail_restaurant/detail_restaurant.dart';
import '../../data/model/review.dart';
import '../../data/model/restaurant.dart';
import '../widget/error_message.dart';
import '../widget/detail_restaurant/add_review_box.dart';
import '../widget/detail_restaurant/review_box.dart';
import '../widget/detail_restaurant/shimmer_effect.dart';
import '../widget/detail_restaurant/box_main_info.dart';
import '../widget/detail_restaurant/description.dart';
import '../widget/detail_restaurant/header_navigation.dart';
import '../widget/detail_restaurant/list_dish.dart';
import '../widget/detail_restaurant/top_image_bg.dart';

class DetailRestaurantScreen extends StatelessWidget {
  const DetailRestaurantScreen(
      {super.key, required this.id, required this.favoriteRestaurants});

  final String id;
  final List<Restaurant> favoriteRestaurants;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<DetailRestaurantBloc>().add(DetailRestaurantFetched(
              restaurantId: id, favoriteRestaurants: favoriteRestaurants));
        },
        color: Colors.amber,
        child: Stack(
          children: [
            ListView(),
            BlocBuilder<DetailRestaurantBloc, DetailRestaurantState>(
              buildWhen: (previous, current) => previous != current,
              builder: (context, state) {
                switch (state) {
                  case DetailRestaurantLoading() || DetailRestaurantInitial():
                    return _shimmerEffect(context);
                  case DetailRestaurantCompleted() ||
                        DetailRestaurantChangeCompleted():
                    return _detailRestaurantView(
                        context, state.detailRestaurant);
                  case DetailRestaurantError():
                    return Stack(
                      children: [
                        HeaderNavigation(
                          detailRestaurant: DetailRestaurant.empty,
                          isFavoriteButtonDisplayed: false,
                        ),
                        errorMessage(state.message)
                      ],
                    );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _detailRestaurantView(
      BuildContext context, DetailRestaurant detailRestaurant) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Stack(children: [
      SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: screenHeight * 0.44,
              child: Stack(
                children: [
                  DetailRestaurantTopImageBG(
                      detailRestaurant: detailRestaurant),
                  DetailRestaurantBoxMainInfo(
                      detailRestaurant: detailRestaurant)
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('About',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                          letterSpacing: 0)),
                  const SizedBox(height: 10),
                  DetailRestaurantDescription(
                      detailRestaurant: detailRestaurant),
                  const SizedBox(height: 20),
                  Text(
                    'Foods',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                          letterSpacing: 0,
                        ),
                  ),
                  const SizedBox(height: 10),
                  DetailRestaurantListDish(dishes: detailRestaurant.menu.foods),
                  const SizedBox(height: 10),
                  Text('Drinks',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                          letterSpacing: 0)),
                  const SizedBox(height: 10),
                  DetailRestaurantListDish(
                      dishes: detailRestaurant.menu.drinks),
                  const SizedBox(height: 30),
                  AddReviewBox(
                    id: detailRestaurant.id,
                  ),
                  const SizedBox(height: 15),
                  _listReviewBox(detailRestaurant.customerReviews),
                  const SizedBox(height: 18),
                ],
              ),
            )
          ],
        ),
      ),
      HeaderNavigation(detailRestaurant: detailRestaurant),
    ]);
  }

  Widget _listReviewBox(List<CustomerReview> customerReview) {
    return Container(
      height: customerReview.length < 4 ? 200 : 350,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: const Border(
          top: BorderSide(width: 1.0, color: Colors.black26),
          bottom: BorderSide(width: 1.0, color: Colors.black26),
        ),
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: customerReview.length,
        itemBuilder: (context, index) =>
            ReviewBox(review: customerReview[index]),
      ),
    );
  }

  Widget _shimmerEffect(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShimmerEffectDetailRestaurant(
              width: screenWidth,
              height: screenHeight * 0.3,
            ),
            ShimmerEffectDetailRestaurant(
              width: screenWidth * 0.8,
              height: screenHeight * 0.05,
            ),
            ShimmerEffectDetailRestaurant(
              width: screenWidth,
              height: screenHeight * 0.2,
            ),
            ShimmerEffectDetailRestaurant(
              width: screenWidth * 0.8,
              height: screenHeight * 0.05,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                      3,
                      (index) => ShimmerEffectDetailRestaurant(
                            width: screenWidth * 0.29,
                            height: screenHeight * 0.2,
                            verticalMargin: 0,
                            horizontalMargin: 0,
                          ))),
            ),
            ShimmerEffectDetailRestaurant(
              width: screenWidth * 0.8,
              height: screenHeight * 0.05,
            )
          ],
        ),
      ),
    );
  }
}
