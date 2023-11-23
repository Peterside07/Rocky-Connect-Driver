import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:rockyconnectdriver/firebase_options.dart';
import 'package:rockyconnectdriver/services/notification.dart';
import 'package:rockyconnectdriver/services/token.dart';

import 'pages/onboarding/splash_screen.dart';



Position? userPosition;

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  
  print("Handling a background message: ${message.messageId}");
}

void main() async{
  
  WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform

 );
 // await FirebaseApi().initNotification();
   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    String? fcmToken = await FirebaseMessaging.instance.getToken();
  print('FCM Token: $fcmToken');
    TokenService.fcmToken = fcmToken ?? '';


  await FirebaseAuth.instance.signInAnonymously();
  Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
      .then((value) {
    log(value.toString(), name: 'position');
    userPosition = value;
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  void _appTimeout() async {}

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onPanDown: (e) => _appTimeout(),
      onPanStart: (e) => _appTimeout(),
      onPanEnd: (e) => _appTimeout(),
      onTap: () => _appTimeout(),
      child:  KeyboardDismissOnTap(
        child:   NotificationWrapper(
        onNotificationTapped: (RemoteMessage message) {
          debugPrint(
              "onNotificationTapped ---->>>>>> ${message.notification?.title}");
        },
        onForeGroundNotificationReceived: (RemoteMessage message) {
          debugPrint(
              "onForeGroundNotificationReceived ---->>>>>> ${message.notification?.title}");
        },
          child: GetMaterialApp(
            theme: ThemeData(primarySwatch: Colors.deepPurple),
            title: 'RockyConnect',
            home: const SplashPage(),
          ),
        ),
      ),
    );
  }
}
