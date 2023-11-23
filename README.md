# Rocky Connect Driver

The 'Rocky Connect Driver` repository is a collection of Flutter packages and applications that drive the
client-side service of Nessvie.

'Rocky Connect Driver created in flutter using `Getx`. Nessvie supports both andriod and IOS, clone the appropriate branches mentioned below:

* For Driver App:  https://github.com/ritzyRosabel/Rocky-Connect-Driver (master channel)
* For Rider App: https://github.com/ritzyRosabel/rockyconnecttest (master channel)


## The Flutter applications

### Mobile app: 'Rocky Connect Driver`

The mobile app is built using Flutter and targets both Android and iOS.

Minimum supported version of Android is `6.0` (23/Marshmallow), and of iOS is `11.0`.

Since Android is an open-source operating system being used by many vendors such Google, Amazon,
Huawei, and others, we’ve made it easy to easily support many vendors and not only Google.

### Rider : `Rider`

The Rocky Connect rider is the mobile app built using flutter and target user to request and accept rides. It enables user to accept trips created by the customer application, approve trip and complete ride.

The app provides a user-friendly interface and seamless integration with backend systems to streamline the driver's workflow and enhance customer service. With the flexibility and cross-platform capabilities of Flutter.


## Getting Started

The Rocky Connect Driver app contains the minimal implementation required to create a new library or project. The repository code is preloaded with some basic components like basic app architecture, app theme, constants and required dependencies to create a new project.

## How to Use 

**Step 1:**

Download or clone this repo by using the link below:

```
https://github.com/ritzyRosabel/Rocky-Connect-Driver

```

**Step 2:**

Go to project root and execute the following command in console to get the required dependencies: 

```
flutter pub get 
```

## Rocky Connect Driver Features:

* Splash
* Login
* Register
* Onboarding
* Request Trip
* Update Car information
* Create Trip
* Schedule Trip
* Payment
* Chat
* Notification
* Routing
* Theme
* Dio
* Database
* GetX (State Management)
* User Notifications


### Libraries & Tools Used

* [Dio](https://pub.dev/packages/dio)
* [Database](https://pub.dev/packages/shared_preferences)(SharedPreference)
* [GetX](https://pub.dev/packages/get) (State Management)
* [Notifications](https://pub.dev/packages/firebase_core)(firebase Cloud)
* Other libraries can be found in the `pubspec.yaml` file 

### Folder Structure
Here is the core folder structure which flutter provides.

```
flutter-app/
|- android
|- build
|- ios
|- lib
|- test
```

Here is the folder structure we have been using in this project

```
lib/
|- controllers/
|- globals/
|- models/
|- screens/
|- services/
|- theme/
|- widgets/
|- main.dart

```
### Main

This is the starting point of the application. All the application level configurations are defined in this file i.e, theme, routes, title, orientation etc.

```dart
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:rockyconnecttest/firebase_options.dart';
import 'package:rockyconnecttest/pages/onboarding/splash_screen.dart';
import 'package:rockyconnecttest/services/token.dart';

import 'services/notification.dart';

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
            home: SplashPage(),
          ),
        ),
      ),
    );
  }
}


## Conclusion

Create! 🙂
