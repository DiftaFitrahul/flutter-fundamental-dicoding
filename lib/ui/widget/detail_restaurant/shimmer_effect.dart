import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerEffectDetailRestaurant extends StatelessWidget {
  const ShimmerEffectDetailRestaurant({
    super.key,
    required this.height,
    required this.width,
    this.horizontalMargin = 12,
    this.verticalMargin = 8,
  });

  final double width;
  final double height;
  final double verticalMargin;
  final double horizontalMargin;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.withOpacity(0.15),
      highlightColor: Colors.grey.withOpacity(0.25),
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: EdgeInsets.symmetric(
            horizontal: horizontalMargin, vertical: verticalMargin),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey,
        ),
        width: width,
        height: height,
      ),
    );
  }
}
