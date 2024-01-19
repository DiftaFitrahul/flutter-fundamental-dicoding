import 'dart:convert';

import 'package:restauran_app_dicoding/constant/api.dart';
import 'package:restauran_app_dicoding/data/db/favorites_db.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../controller/bloc/detail_restaurant/detail_restaurant_bloc.dart';
import '../data/model/restaurant.dart';
import '../ui/screen/detail.dart';
import './download_image.dart';

final selectNotificationSubject = BehaviorSubject<String>();

class NotificationHelper {
  static NotificationHelper? _instance;
  static const _channelId = 'channel_01';
  static const _channelName = 'restaurant_channel';
  static const _channelDescription = 'restaurant notification channel';

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<void> initNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    final details =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

    if (details != null && details.didNotificationLaunchApp) {
      selectNotificationSubject
          .add(details.notificationResponse?.payload ?? '');
    }

    const initializationSettingsAndroid =
        AndroidInitializationSettings('restaurant');
    const initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false);
    const initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        selectNotificationSubject.add(details.payload ?? '');
      },
    );
  }

  Future<void> showNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      Restaurant restaurant) async {
    var bigPicturePath = await Utils.downloadFile(
        '$baseImageURL/${restaurant.pictureId}', 'restauranImage');

    var bigPictureAndroidStyle = BigPictureStyleInformation(
        FilePathAndroidBitmap(bigPicturePath),
        htmlFormatContent: true,
        htmlFormatTitle: true);
    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
        _channelId, _channelName,
        channelDescription: _channelDescription,
        importance: Importance.max,
        sound: const RawResourceAndroidNotificationSound('notif_sound'),
        priority: Priority.high,
        ticker: 'ticker',
        styleInformation: bigPictureAndroidStyle);

    const iOSPlatformChannelSpecifics = DarwinNotificationDetails();

    final platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    final titleNotification = "<b>${restaurant.name} </b>";
    final bodyNotification = restaurant.description;

    await flutterLocalNotificationsPlugin.show(
        0, titleNotification, bodyNotification, platformChannelSpecifics,
        payload: jsonEncode(restaurant.toJson()));
  }

  void handleSelectNotificationSubject(BuildContext context, String routeName) {
    selectNotificationSubject.stream.listen((payload) async {
      await FavoritesDB().getFavorites().then((listFavoriteRestaurants) {
        final data = Restaurant.fromJson(jsonDecode(payload));
        context.read<DetailRestaurantBloc>().add(DetailRestaurantFetched(
            restaurantId: data.id,
            favoriteRestaurants: listFavoriteRestaurants));
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailRestaurantScreen(
                  id: data.id, favoriteRestaurants: listFavoriteRestaurants),
            ));
      });
    });
  }
}
