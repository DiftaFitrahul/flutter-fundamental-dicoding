import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:device_preview/device_preview.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../controller/bloc/favorite/favorites.dart';
import '../controller/cubit/bottom_nav_cubit.dart';
import '../controller/cubit/scheduled_restaurant_notif_cubit.dart';
import '../controller/bloc/detail_restaurant/detail_restaurant.dart';
import '../controller/bloc/restaurant/restaurant.dart';
import '../controller/bloc/review/review.dart';
import '../data/db/favorites_db.dart';
import '../data/preferences/preferences_helper.dart';
import '../data/repository/restaurant_api_service.dart';
import '../utils/background_service.dart';
import '../utils/notification_helper.dart';
import '../routes/routes.dart';
import '../constant/text_theme.dart';
import '../constant/color.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final notificationHelper = NotificationHelper();
  final backgroundService = BackgroundService();

  backgroundService.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }

  await notificationHelper.initNotification(flutterLocalNotificationsPlugin);
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RestaurantBloc>(
          create: (_) => RestaurantBloc(
              restaurantAPIService: RestaurantAPIService(Client()))
            ..add(const ListRestaurantFetched()),
        ),
        BlocProvider<DetailRestaurantBloc>(
          create: (_) => DetailRestaurantBloc(
              restaurantAPIService: RestaurantAPIService(Client())),
        ),
        BlocProvider<ReviewBloc>(
          create: (_) =>
              ReviewBloc(restaurantAPIService: RestaurantAPIService(Client())),
        ),
        BlocProvider<FavoritesBloc>(
          create: (_) => FavoritesBloc(favoritesDB: FavoritesDB())
            ..add(FavoritesFetched()),
        ),
        BlocProvider<BottomNavigationCubit>(
          create: (_) => BottomNavigationCubit(),
        ),
        BlocProvider<ScheduledRestaurantNotificationCubit>(
          create: (_) => ScheduledRestaurantNotificationCubit(
              preferencesHelper: PreferencesHelper(
                  sharedPreferences: SharedPreferences.getInstance())),
        ),
      ],
      child: MaterialApp.router(
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        routerConfig: GoRouteClass.routerConfig(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: primaryColor,
                secondary: secondaryColor,
              ),
          textTheme: myTextTheme,
          appBarTheme: const AppBarTheme(
            elevation: 0,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                backgroundColor: secondaryColor,
                foregroundColor: Colors.white,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(0)),
                )),
          ),
        ),
      ),
    );
  }
}
