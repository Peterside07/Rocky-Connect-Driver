// ignore_for_file: non_constant_identifier_names

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  debugPrint('Title: ${message.notification?.title}');
  debugPrint('Body: ${message.notification?.body}');
  debugPrint('Payload: ${message.data}');
}

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission();
    final FCMToken = await _firebaseMessaging.getToken();
    debugPrint('Token: $FCMToken');

    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }
}
