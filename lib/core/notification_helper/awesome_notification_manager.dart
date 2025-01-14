import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:azkar/features/azkar/data/azkar_screen_body_item_model_data.dart';
import 'package:azkar/features/azkar/presentation/veiw/screens/azkar_details_screen.dart';
import 'package:azkar/features/home/presentation/view/screens/home_screen.dart';
import 'package:azkar/main.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class AwesomeNotificationManager {
  static Future<void> initialize() async {
    await AwesomeNotifications().initialize(
      'resource://drawable/quran2',
      [
        NotificationChannel(
          channelKey: "schedule_azkar_channel",
          channelName: 'schedule notifications',
          channelDescription: 'Notification channel for schedule tests',
          importance: NotificationImportance.Max,
          channelShowBadge: false,
          groupAlertBehavior: GroupAlertBehavior.Children,
          enableLights: true,
          enableVibration: true,
          defaultPrivacy: NotificationPrivacy.Public,
          onlyAlertOnce: true,
          playSound: true,
          // soundSource: 'resource://raw/adan',
        ),
      ],
    );
    await requestNotificationPermission();
    onActionReceived();
  }

  static Future<void> requestNotificationPermission() async {
    if (await Permission.notification.isDenied) {
      await Permission.notification.request();
    }
  }

  static Future<void> scheduleAzkarNotification({
    required int id,
    required String title,
    required String body,
    required int selectedHour,
    required int selectedMinute,
    required bool isRepeating,
  }) async {
    final notificationContent = NotificationContent(
      id: id,
      channelKey: "schedule_azkar_channel",
      title: title,
      body: body,
      icon: 'resource://drawable/quran2',
      notificationLayout: NotificationLayout.Default,
    );
    final schedule = NotificationCalendar(
      hour: selectedHour,
      minute: selectedMinute,
      second: 0,
      repeats: isRepeating,
      timeZone: await AwesomeNotifications().getLocalTimeZoneIdentifier(),
    );

    await AwesomeNotifications().createNotification(
      content: notificationContent,
      schedule: schedule,
    );
  }

  static void onActionReceived() {
    AwesomeNotifications()
        .setListeners(onActionReceivedMethod: onActionReceivedMethod);
  }

  @pragma('vm:entry-point')
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    if (receivedAction.actionType == ActionType.SilentAction ||
        receivedAction.actionType == ActionType.SilentBackgroundAction) {
    } else {
      return onActionReceivedImplementationMethod(receivedAction);
    }
  }

  static Future<void> onActionReceivedImplementationMethod(
      ReceivedAction receivedAction) async {
    MyApp.navigatorKey.currentState?.pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) {
          if (receivedAction.channelKey == "schedule_azkar_channel") {
            return AzkarDetailsScreen(
              azkarScreenBodyItemModel:
                  azkarScreenBodyItemModel[receivedAction.id!],
            );
          }
          return const HomeScreen();
        },
      ),
      (route) => false,
    );
  }
}
