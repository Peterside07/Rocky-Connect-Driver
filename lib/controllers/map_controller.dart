import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_place/google_place.dart';
import 'package:rockyconnectdriver/models/trip_response.dart';

import 'package:rockyconnectdriver/models/app_alert.dart';
import 'package:rockyconnectdriver/pages/home/home_screen.dart';
import 'package:rockyconnectdriver/services/api.dart';

import '../global/endpoints.dart';
import '../pages/trip/select_trip.dart';
import 'global_controller.dart';

class MapController extends GetxController {
  TextEditingController dateControllerCtx = TextEditingController(text: '');
  TextEditingController timeControllerCtx = TextEditingController(text: '');
  TextEditingController passwordCtx = TextEditingController(text: '');
  TextEditingController emailCtx = TextEditingController(text: '');

  var isLoading = false.obs;
  var password = ''.obs;
  var loading = false.obs;
  var emailAddress = ''.obs;
  var oldPin = ''.obs;
  var newPin = ''.obs;
  var confirmPin = ''.obs;
  var startPosition = DetailsResult().obs;
  var endPosition = DetailsResult().obs;
  var startName = ''.obs;
  var endName = ''.obs;
  var tripDistination = ''.obs;
  var distance = 0.0.obs;
  var startLat = 0.0.obs;
  var startLng = 0.0.obs;
  var startState = ''.obs;
  var endState = ''.obs;
  var endLat = 0.0.obs;
  var endLng = 0.0.obs;
  var tripDistance = 0.0.obs;
  var averageSpeed = 10;
  var selectedDateTime = DateTime.now().obs;
  var formattedDateTime = ''.obs;
  var tripResponse = TripResponse().obs;
  var trip = <TripResponse>[].obs;
  var idTrip = ''.obs;
  var customerEmail = ''.obs;
  final ctrl = Get.put(GlobalController());

double calculateTotalTime(double tripDistance) {
  double averageSpeed = 60.0; // Average speed in kilometers per hour

  // Calculate totalTime in hours
  double totalTimeInHours = tripDistance / averageSpeed;

  // Convert totalTime to minutes
  double totalTimeInMinutes = totalTimeInHours * 60.0;

  return totalTimeInMinutes;
}
  //Search for Driver
  void searchForDriver() async {
    var data = {
      "destinationState": endState.value.toString(),
      "destinationLong": endLng.value.toString(),
      "destinationLat": endLat.value.toString(),
      "tripInitiator": "Driver",
      "tripDate": formattedDateTime.value.toString()
    };

    loading.value = true;
    var res = await Api().post(Endpoints.SEARCH_TRIP_FOR_PASSENGER, data);
    loading.value = false;

    if (res.respCode == 0) {
      if (res.data != null) {
        trip.assignAll((res.data as List)
            .map((item) => TripResponse.fromJson(item))
            .toList());

        Get.to(() => const SelectDrip());
      }

      AppAlert(
        message: res.respDesc,
        type: AlertType.SUCCESS,
      ).showAlert();
    } else {
      AppAlert(
        type: AlertType.INFO,
        message: res.respDesc).showAlert();
    }
  }

  //Search for Driver
  void scheduleTrip() async {
    var data = {
       "customerEmail": '',
      "driverEmail": ctrl.email.text,
      "sourceLocation": startName.value.toString(),
      "sourceLongitude": startLat.value.toString(),
      "sourceLatitude": startLng.value.toString(),
      "destination": endName.value.toString(),
      "destinationLong": endLng.value.toString(),
      "destinationLat": endLat.value.toString(),
      "destinationState": endState.value.toString(),
      "tripDistance": distance.value.toInt(),
      "totalTime": calculateTotalTime(distance.toDouble()).toInt(),
      "tripInitiator": "Driver",
      "tripDate": formattedDateTime.value,
    };

    isLoading.value = true;
    var res = await Api().post(Endpoints.SCHEDULETRIP, data);
    isLoading.value = false;

    if (res.respCode == 0) {
      AppAlert(
        message: res.respDesc,
        type: AlertType.SUCCESS,
      ).showAlert();

      Get.offAll(() => const HomeScreen());
    } else {
      AppAlert(message: res.respDesc).showAlert();
    }
  }

  //approve for Driver
  void approveTrip() async {
    var data = {
      "id": idTrip.value,
      "customerEmail": customerEmail.value,
      "driverEmail": ctrl.email.text,
      "cancelReason": "ApprovedTrip",
    };

    loading.value = true;
    var res = await Api().put(Endpoints.APPROVED_USER_FOR_A_TRIP, data);
    loading.value = false;

    if (res.respCode == 0) {
      Get.offAll(() => const HomeScreen());

      AppAlert(
        message: res.respDesc,
        type: AlertType.SUCCESS,
      ).showAlert();
    } else {
      AppAlert(message: res.respDesc).showAlert();
    }
  }

  //Decline for Driver
  void declineTrip() async {
    var data = {
      "id": idTrip.value,
      "customerEmail": customerEmail.value,
      "driverEmail": ctrl.email.text,
      "cancelReason": "DeclineTrip",
    };

    loading.value = true;
    var res = await Api().put(Endpoints.DECLINE_USER_FOR_A_TRIP, data);
    loading.value = false;

    if (res.respCode == 0) {
      Get.offAll(() => const HomeScreen());

      AppAlert(
        message: res.respDesc,
        type: AlertType.SUCCESS,
      ).showAlert();
    } else {
      AppAlert(message: res.respDesc).showAlert();
    }
  }

  void startTrip(String id) async {
    var data = {
      "id": id,
    };

    loading.value = true;
    var res = await Api().put(Endpoints.START_TRIP, data);
    loading.value = false;

    if (res.respCode == 0) {
      // Get.back();

      AppAlert(
        message: res.respDesc,
        type: AlertType.SUCCESS,
      ).showAlert();
    } else {
      AppAlert(message: res.respDesc).showAlert();
    }
  }

  void endTrip(String id) async {
    var data = {
      "id": id,
    };

    loading.value = true;
    var res = await Api().put(Endpoints.END_TRIP, data);
    loading.value = false;

    if (res.respCode == 0) {
      Get.back();

      AppAlert(
        message: res.respDesc,
        type: AlertType.SUCCESS,
      ).showAlert();
    } else {
      AppAlert(message: res.respDesc).showAlert();
    }
  }
}
