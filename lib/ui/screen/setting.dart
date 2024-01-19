import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controller/cubit/scheduled_restaurant_notif_cubit.dart';
import '../widget/custom_dialog.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          children: [
            const SizedBox(height: 30),
            Text(
              'Settings',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 20),
            Material(
              child: ListTile(
                title: const Text('Scheduling News'),
                trailing:
                    BlocBuilder<ScheduledRestaurantNotificationCubit, bool>(
                  builder: (context, isScheduled) {
                    return Switch.adaptive(
                      value: isScheduled,
                      onChanged: (value) {
                        if (Platform.isIOS) {
                          customDialog(context);
                        } else {
                          context
                              .read<ScheduledRestaurantNotificationCubit>()
                              .scheduledNotification(value);
                        }
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
