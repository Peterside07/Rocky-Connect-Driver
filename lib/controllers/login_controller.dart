import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rockyconnectdriver/global/endpoints.dart';
import '../models/app_alert.dart';
import '../models/user_model.dart';
import '../pages/home/home_screen.dart';
import '../services/api.dart';
import 'global_controller.dart';

class LoginController extends GetxController {
  TextEditingController passwordCtx = TextEditingController(text: '');
  TextEditingController emailCtx = TextEditingController(text: '');

  var isLoading = false.obs;
  var password = ''.obs;
  var loading = false.obs;
  var emailAddress = ''.obs;
  var oldPin = ''.obs;
  var newPin = ''.obs;
  var confirmPin = ''.obs;

  final globalCtx = Get.put(GlobalController());

  void handleError(String message) {
    AppAlert(
      title: 'Login error'.tr,
      message: message,
    ).showAlert();
  }

  Future<void> userLogin() async {
    final data = {
      'email': emailAddress.value,
      'password': password.value,
    };

    isLoading.value = true;
    final res = await Api().post(Endpoints.LOGIN, data);

    isLoading.value = false;

    if (res.respCode == 0) {
      globalCtx.user.value = UserModel.fromJson(res.data);
      globalCtx.setFieldsForEdit();
      AppAlert(
        message: res.respDesc,
        type: AlertType.SUCCESS,
      ).showAlert();

      Get.offAll(() => HomeScreen());
    } else {
      AppAlert(message: res.respDesc).showAlert();
    }
  }
}
