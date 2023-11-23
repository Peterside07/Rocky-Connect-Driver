// To parse this JSON data, do
//
//     final notification = notificationFromJson(jsonString);

import 'dart:convert';

NotificationModel notificationFromJson(String str) => NotificationModel.fromJson(json.decode(str));

String notificationToJson(NotificationModel data) => json.encode(data.toJson());

class NotificationModel {
    String? notificationId;
    String? email;
    String? title;
    String? body;
    DateTime? dateSent;

    NotificationModel({
        this.notificationId,
        this.email,
        this.title,
        this.body,
        this.dateSent,
    });

    factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
        notificationId: json["notificationID"],
        email: json["email"],
        title: json["title"],
        body: json["body"],
        dateSent: json["dateSent"] == null ? null : DateTime.parse(json["dateSent"]),
    );

    Map<String, dynamic> toJson() => {
        "notificationID": notificationId,
        "email": email,
        "title": title,
        "body": body,
        "dateSent": dateSent?.toIso8601String(),
    };
}
