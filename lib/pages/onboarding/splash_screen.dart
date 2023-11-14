import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:rockyconnectdriver/pages/onboarding/getting_started.dart';


import '../../controllers/global_controller.dart';
import '../../models/app_alert.dart';
import '../../services/storage.dart';
import '../../theme/colors.dart';
import '../../widgets/utils.dart';
import '../auth/signIn.dart';

class SplashPage extends StatefulWidget {
  SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final ctrl = Get.put(GlobalController());

  @override
  void initState() {
    // determinePosition();
    determinePosition().then((location) {
      ctrl.setUserLocation(location);
      navigateToNextPage();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.PRIMARY_COLOR,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image(
              image: AssetImage('assets/images/onboarding_ride.png'),
            ),
          ),
          SizedBox(height: 20),
          Text(
            "Nowhere is beyond \nreach with Rocky \nConnect ",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFFE4CAFF),
              fontSize: 32,
              fontFamily: 'Open Sans',
              fontWeight: FontWeight.w700,
              height: 0,
            ),
          ),
        ],
      ),
    );
  }

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> determinePosition() async {
    LocationPermission permission;

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

    navigateToNextPage();
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  void navigateToNextPage() {
    Future.delayed(const Duration(seconds: 2), () async {
      var viewed = await StorageService().getViewedWalkthrough();
      Get.off(() => viewed ? SignIn() : const GettingStartedPage());
    });
  }
}
