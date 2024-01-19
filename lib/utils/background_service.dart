import 'dart:isolate';
import 'dart:ui';

import 'package:http/http.dart';

import '../main.dart';
import '../data/model/restaurant.dart';
import '../data/repository/restaurant_api_service.dart';
import '../utils/notification_helper.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService? _instance;
  static const String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  BackgroundService._internal() {
    _instance = this;
  }

  factory BackgroundService() => _instance ?? BackgroundService._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(port.sendPort, _isolateName);
  }

  @pragma('vm:entry-point')
  static Future<void> callback() async {
    final NotificationHelper notificationHelper = NotificationHelper();

    List<Restaurant> listRestaurant = [];
    bool isSuccesGetData = false;

    try {
      final allRestaurant =
          await RestaurantAPIService(Client()).getListRestauran();
      listRestaurant = allRestaurant.restaurants;
      isSuccesGetData = true;
    } catch (_) {
      isSuccesGetData = false;
    }

    if (isSuccesGetData && listRestaurant.isNotEmpty) {
      listRestaurant.shuffle();

      await notificationHelper.showNotification(
          flutterLocalNotificationsPlugin, listRestaurant.first);
    }

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }
}
