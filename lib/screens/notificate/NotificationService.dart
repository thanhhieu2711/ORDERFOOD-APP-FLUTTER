import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:foodorder_app/config/colors.dart';
import 'package:foodorder_app/screens/order/list_order.dart';

class NotificationServices {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final AndroidInitializationSettings _androidInitializationSettings =
      const AndroidInitializationSettings('@mipmap/ic_launcher');

  void onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      debugPrint('notification payload: $payload');
    }
    await Navigator.push(
      payload as BuildContext,
      MaterialPageRoute<void>(builder: (context) => ListOrder()),
    );
  }

  void inititaliseNotifications() async {
    InitializationSettings initializationSettings = InitializationSettings(
      android: _androidInitializationSettings,
    );
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);
  }

  void sendNotification(
    String? title,
    String? body,
    String? payload,
  ) async {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails("channelId", "channelName",
            icon: "@mipmap/ic_launcher",
            priority: Priority.max,
            importance: Importance.max,
            enableVibration: true,
            color: primaryColor);
    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );
    _flutterLocalNotificationsPlugin.show(0, title, body, notificationDetails);
  }
}
