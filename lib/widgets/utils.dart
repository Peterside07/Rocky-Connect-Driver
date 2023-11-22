// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:rockyconnectdriver/models/app_alert.dart';

class Utils {
  static BoxShadow appBoxShadow() {
    return BoxShadow(
      offset: const Offset(0, 3),
      blurRadius: 26,
      color: Get.isDarkMode ? Colors.black : const Color.fromRGBO(0, 0, 0, 0.15),
    );
  }

  static appBar(BuildContext context, {String title = ''}) {
    return AppBar(
      centerTitle: true,
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .headline1
            ?.copyWith(fontSize: 17, fontWeight: FontWeight.bold),
      ),
    );
  }

  static showAlert(
    String message, {
    String title = '',
    AlertType type = AlertType.ERROR,
  }) {
    AppAlert(message: message, title: title, type: type).showAlert();
  }

  static showSheetOptions(Widget view) {
    Get.bottomSheet(
      view,
      enableDrag: true,
      isScrollControlled: true,
      ignoreSafeArea: false,
      isDismissible: true,
    );
  }

  static void goBack({required int steps}) {
    for (var i = 1; i <= steps; i++) {
      Get.back();
    }
  }

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  static Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        Utils.showAlert(
          'Please Accept Location permission',
          type: AlertType.INFO,
        );
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Utils.showAlert(
        'Please Accept Location permission in app Settings',
        type: AlertType.INFO,
      );
      await Geolocator.openLocationSettings();
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
}
