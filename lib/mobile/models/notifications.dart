import 'dart:convert';

import 'package:flemis/mobile/models/notification_type.dart';

class Notifications {
  Notifications(
      {this.idNotification,
      this.createdAt,
      this.message,
      this.notificationType,
      this.idContent,
      this.createdBy,
      this.userNotified});
  String? idNotification;
  String? idContent;
  DateTime? createdAt;
  NotificationType? notificationType;
  String? message;
  String? createdBy;
  String? userNotified;

  factory Notifications.fromJson(String str) =>
      Notifications.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Notifications.fromMap(Map<String, dynamic> json) => Notifications(
        idNotification: json["_id"],
        idContent: json["idContent"],
        notificationType:
            NotificationType.values.elementAt(json["notificationType"] as int),
        message: json["message"],
        userNotified: json["userNotified"],
        createdBy: json["createdBy"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.tryParse(json["createdAt"]),
      );

  Map<String, dynamic> toMap() => {
        "_id": idNotification,
        "notificationType": notificationType?.index,
        "message": message,
        "idContent": idContent,
        "createdAt": createdAt?.toIso8601String(),
      };
}
