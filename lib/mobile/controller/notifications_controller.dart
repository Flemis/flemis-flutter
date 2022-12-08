import 'package:flemis/mobile/services/notification_service.dart';
import 'package:flutter/material.dart';

import '../models/notifications.dart';

class NotificationsController {
  NotificationsController({this.context});

  final BuildContext? context;
  final NotificationService notificationServices = NotificationService();

  Future<dynamic> getNotifications(String userId) async {
    return await notificationServices
        .fetchNotifications(userId)
        .catchError((error, stack) {
      return error;
    }).then((response) {
      if (response.status >= 200 && response.status <= 299) {
        List<Notifications> notifications = [];
        response.result.forEach(
            (element) => notifications.add(Notifications.fromMap(element)));
        return notifications;
      } else {
        return Future.error(response.message.toString());
      }
    });
  }
}
