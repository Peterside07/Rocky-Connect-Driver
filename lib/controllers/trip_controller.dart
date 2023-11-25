import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rockyconnectdriver/models/trip_response.dart';

import 'package:rockyconnectdriver/models/app_alert.dart';
import 'package:rockyconnectdriver/services/api.dart';

import '../global/endpoints.dart';
import '../pages/trip/refund_trip.dart';
import '../widgets/utils.dart';
import 'global_controller.dart';

class TripController extends GetxController {
  TextEditingController dateControllerCtx = TextEditingController(text: '');
  TextEditingController timeControllerCtx = TextEditingController(text: '');
  TextEditingController passwordCtx = TextEditingController(text: '');
  TextEditingController emailCtx = TextEditingController(text: '');

  var isLoading = false.obs;
  var loading = false.obs;
  var selectedDateTime = DateTime.now().obs;
  var formattedDateTime = ''.obs;
  var tripResponse = TripResponse().obs;
  var upcomingTrip = <TripResponse>[].obs;
  var completedTrip = <TripResponse>[].obs;
  var approvedTrip = <TripResponse>[].obs;
  var requestedTrip = <TripResponse>[].obs;
  var unrequestTrip = <TripResponse>[].obs;

  final ctrl = Get.put(GlobalController());

  @override
  void onReady() {
    fetchRequestedTrip();
    fetchCompletedTrip();
    fetchUnrequestedTrip();
    fetchApprovedTrip();
    super.onReady();
  }

  void fetchRequestedTrip() async {
      final email = ctrl.email.text;
    String encodedEmail = Uri.encodeComponent(email);
 
    loading.value = true;
    var res = await Api().get(
        '${Endpoints.REQUEST_TRIPS_AWAITING_APPROVAL}?email=$encodedEmail');
    loading.value = false;

    if (res.respCode == 0) {
      if (res.data != null) {
        requestedTrip.assignAll((res.data as List)
            .map((item) => TripResponse.fromJson(item))
            .toList());
      }
    } else {
      AppAlert(message: res.respDesc).showAlert();
    }
  }

  void fetchCompletedTrip() async {
      final email = ctrl.email.text;
    String encodedEmail = Uri.encodeComponent(email);
    loading.value = true;
    var res = await Api().get(
      '${Endpoints.COMPLETED_TRIP}?email=$encodedEmail',
    );
    loading.value = false;

    if (res.respCode == 0) {
      if (res.data != null) {
        completedTrip.assignAll((res.data as List)
            .map((item) => TripResponse.fromJson(item))
            .toList());
      }
    } else {
      AppAlert(message: res.respDesc).showAlert();
    }
  }

  void fetchApprovedTrip() async {
    final email = ctrl.email.text;
    String encodedEmail = Uri.encodeComponent(email);
    debugPrint(encodedEmail);

    loading.value = true;
    var res = await Api().get(
      '${Endpoints.APPROVED_TRIP}?email=$encodedEmail',
    );
    loading.value = false;

    if (res.respCode == 0) {
      if (res.data != null) {
        approvedTrip.assignAll((res.data as List)
            .map((item) => TripResponse.fromJson(item))
            .toList());
      }
    } else {
     // AppAlert(message: res.respDesc).showAlert();
    }
  }

  void fetchUnrequestedTrip() async {
    final email = ctrl.email.text;
    String encodedEmail = Uri.encodeComponent(email);

    loading.value = true;
    var res = await Api().get(
      '${Endpoints.DRIVER_UNREQUESTED_TRIPS}?email=$encodedEmail',
    );
    loading.value = false;

    if (res.respCode == 0) {
      if (res.data != null) {
        unrequestTrip.assignAll((res.data as List)
            .map((item) => TripResponse.fromJson(item))
            .toList());
      }
    } else {
   //   AppAlert(message: res.respDesc).showAlert();
    }
  }

   void cancelATripWithReason(String id, String reason) async {
    var data = {
      'id': id,
      "reasonForCancel": reason,
    };

    loading.value = true;
    var response = await Api().delete(Endpoints.CANCEL_TRIP, data);

    loading.value = false;

    if (response.respCode == 0) {
      AppAlert(
        message: response.respDesc,
        type: AlertType.SUCCESS,
      ).showAlert();
      Get.to(() => RefundTrip());
    } else {
      Utils.showAlert(response.respDesc);
    }
  }

}
