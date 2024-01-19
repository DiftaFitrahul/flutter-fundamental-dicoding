import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/model/restaurant.dart';
import '../ui/screen/app.dart';
import '../ui/screen/detail.dart';
import '../ui/screen/splash.dart';
import './routes_name.dart';

class GoRouteClass {
  const GoRouteClass._();
  static RouterConfig<Object>? routerConfig() {
    return GoRouter(initialLocation: RoutesName.splash, routes: [
      GoRoute(
        path: RoutesName.splash,
        builder: (_, __) => const SplashScreen(),
      ),
      GoRoute(
        name: RoutesName.mainApp,
        path: RoutesName.mainApp,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: const MainApp(),
            transitionDuration: const Duration(milliseconds: 400),
            transitionsBuilder: (_, animation, __, child) => FadeTransition(
              opacity: animation,
              child: child,
            ),
          );
        },
      ),
      GoRoute(
          name: RoutesName.detailRestaurant,
          path: RoutesName.detailRestaurant,
          builder: (context, state) {
            final data = state.extra as Map<String, dynamic>;
            final id = data['restaurantId'] as String;
            final favoriteRestaurants =
                data['favoriteRestaurants'] as List<Restaurant>;
            return DetailRestaurantScreen(
                id: id, favoriteRestaurants: favoriteRestaurants);
          })
    ]);
  }
}
