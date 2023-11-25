// ignore_for_file: non_constant_identifier_names, depend_on_referenced_packages

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';



Future<void> handleBackgroundMessage(RemoteMessage message) async {
  debugPrint('Title: ${message.notification?.title}');
  debugPrint('Body: ${message.notification?.body}');
  debugPrint('Payload: ${message.data}');
}

class FirebaseApi {
   // for sending push notification
  static Future<void> sendPushNotification(
       user, String msg) async {
    try {
      final body = {
        "to":  user,
        "notification": {
          "title": 'You have a new message!',
          //Utils.capitalize( user.driverFirstName ?? ''),
          "body": msg,
          "android_channel_id": "chats"
        },
      
      };

      var res = await post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader:
                'key=AAAAs-ND9bc:APA91bGvL5LNEiq3Wm94mOOUTlvTabwSAE4Rqrs4lyloW3JfJVP_5GonO0mf9fV3bIBvRLKQosa-EZ7GDhMcra-b09Kn-loq8IuI38QxKLHC0W8MbZIjwdkBB-jqzvslffLLRU2i4TyJ'
          },
          body: jsonEncode(body));
      log('Response status: ${res.statusCode}');
      log('Response body: ${res.body}');
    } catch (e) {
      log('\nsendPushNotificationE: $e');
    }
  }
}

