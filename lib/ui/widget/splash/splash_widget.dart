import 'package:flutter/material.dart';

import '../../../constant/assets_path.dart';

class SplashWidget extends StatelessWidget {
  const SplashWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: screenWidth * 0.65,
              width: screenWidth * 0.65,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Image.asset(
                    logoPath,
                    fit: BoxFit.cover,
                  )),
            ),
          ),
          Align(
            alignment: const Alignment(0, 0.95),
            child: Text(
              'Powered by @Difta Fitrahul Qihaj',
              style: Theme.of(context).textTheme.titleSmall,
            ),
          )
        ],
      ),
    );
  }
}
