import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  final Future<SharedPreferences> sharedPreferences;

  PreferencesHelper({required this.sharedPreferences});

  static const _dailyRestaurantNotification = "DAILY_RESTAURANT_NOTIFICATION";

  Future<bool> get isDailyRestaurantNotificationActive async {
    final pref = await sharedPreferences;
    final result = pref.getBool(_dailyRestaurantNotification);

    return result ?? false;
  }

  Future<void> setDailyRestaurantNotification(bool value) async {
    final pref = await sharedPreferences;
    pref.setBool(_dailyRestaurantNotification, value);
  }
}
