import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class RestaurantShimmerEffect extends StatelessWidget {
  const RestaurantShimmerEffect({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      height: 115,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey.withOpacity(0.15),
            highlightColor: Colors.grey.withOpacity(0.25),
            child: Container(
              padding: const EdgeInsets.only(left: 12),
              margin: const EdgeInsets.symmetric(
                vertical: 8,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey,
              ),
              width: 120,
              height: 100,
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey.withOpacity(0.15),
                  highlightColor: Colors.grey.withOpacity(0.25),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey,
                    ),
                    width: screenWidth * 0.5,
                    height: 20,
                  ),
                ),
                Shimmer.fromColors(
                  baseColor: Colors.grey.withOpacity(0.15),
                  highlightColor: Colors.grey.withOpacity(0.25),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey,
                    ),
                    width: double.infinity,
                    height: 40,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
