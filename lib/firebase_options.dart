// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAJqs-KCcn3b8JkW4KU9pjN_BDrExUNKlU',
    appId: '1:772612027831:web:8942cf6d6821aa4ddca432',
    messagingSenderId: '772612027831',
    projectId: 'rockyconnectride',
    authDomain: 'rockyconnectride.firebaseapp.com',
    storageBucket: 'rockyconnectride.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDZ-q4fGB49W25_5x33YvU1cG3PtyBJZSI',
    appId: '1:772612027831:android:100e194bc8245818dca432',
    messagingSenderId: '772612027831',
    projectId: 'rockyconnectride',
    storageBucket: 'rockyconnectride.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDvQGzezINzQVT_YtuxBBhDqaE5e1WAEsw',
    appId: '1:772612027831:ios:b777afa603fc4f76dca432',
    messagingSenderId: '772612027831',
    projectId: 'rockyconnectride',
    storageBucket: 'rockyconnectride.appspot.com',
    iosBundleId: 'com.rocky.rockyconnectdriver',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDvQGzezINzQVT_YtuxBBhDqaE5e1WAEsw',
    appId: '1:772612027831:ios:855f7a48f9bc0b63dca432',
    messagingSenderId: '772612027831',
    projectId: 'rockyconnectride',
    storageBucket: 'rockyconnectride.appspot.com',
    iosBundleId: 'com.rocky.rockyconnectdriver.RunnerTests',
  );
}
