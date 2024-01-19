import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/preferences/preferences_helper.dart';
import '../../utils/background_service.dart';
import '../../utils/datetime_helper.dart';

class ScheduledRestaurantNotificationCubit extends Cubit<bool> {
  ScheduledRestaurantNotificationCubit(
      {required PreferencesHelper preferencesHelper})
      : _preferencesHelper = preferencesHelper,
        super(false) {
    isDailyRestaurantNotificationActive();
  }

  final PreferencesHelper _preferencesHelper;

  Future<void> isDailyRestaurantNotificationActive() async {
    try {
      final isScheduled =
          await _preferencesHelper.isDailyRestaurantNotificationActive;
      if (isScheduled) {
        emit(true);
      } else {
        emit(false);
      }
    } catch (err) {
      emit(false);
    }
  }

  Future<void> scheduledNotification(bool scheduled) async {
    try {
      await _preferencesHelper.setDailyRestaurantNotification(scheduled);
      emit(scheduled);
      if (scheduled) {
        await AndroidAlarmManager.periodic(
          const Duration(hours: 24),
          1,
          BackgroundService.callback,
          startAt: DateTimeHelper.format(),
          exact: true,
          wakeup: true,
        );
      } else {
        AndroidAlarmManager.cancel(1);
      }
    } catch (err) {
      emit(false);
    }
  }
}
