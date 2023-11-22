import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:rockyconnectdriver/firebase_options.dart';
import 'package:rockyconnectdriver/pages/onboarding/splash_screen.dart';


Position? userPosition;

void main() async{
  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
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

  void _appTimeout() async {
    // if (Get.currentRoute != '/Signin' && token.isNotEmpty) {
    //   await StorageService().removeToken();
    //   Get.offAll(() => Signin());
    // }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onPanDown: (e) => _appTimeout(),
      onPanStart: (e) => _appTimeout(),
      onPanEnd: (e) => _appTimeout(),
      onTap: () => _appTimeout(),
      child:  KeyboardDismissOnTap(
        child: GetMaterialApp(
          theme: ThemeData(primarySwatch: Colors.deepPurple),
          title: 'Rocky Connect',
          home: const SplashPage(),
        ),
      ),
    );
  }
}
