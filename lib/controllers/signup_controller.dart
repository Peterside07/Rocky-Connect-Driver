import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rockyconnectdriver/global/endpoints.dart';
import 'package:rockyconnectdriver/otp.dart';
import 'package:rockyconnectdriver/pages/auth/forget%20password/update_password.dart';
import 'package:rockyconnectdriver/pages/auth/sign_in.dart';
import 'package:rockyconnectdriver/pages/auth/update_car.dart';
import 'package:rockyconnectdriver/services/api.dart';

import '../models/app_alert.dart';
import 'global_controller.dart';

class SignupController extends GetxController {
  TextEditingController phoneCtrl = TextEditingController(text: '');
  TextEditingController passwordCtrl = TextEditingController(text: '');
  TextEditingController confirmPasswordCtrl = TextEditingController(text: '');
  TextEditingController otpCtrl = TextEditingController(text: '');
  TextEditingController fnCtrl = TextEditingController(text: '');
  TextEditingController lnCtrl = TextEditingController(text: '');
  TextEditingController emailCtrl = TextEditingController(text: '');
  TextEditingController driverLiscenseCtrl = TextEditingController(text: '');
  TextEditingController carMakeCtrl = TextEditingController(text: '');
  TextEditingController carModelCtrl = TextEditingController(text: '');
  TextEditingController carTypeCtrl = TextEditingController(text: '');
  TextEditingController carPlateNumberCtrl = TextEditingController(text: '');
  TextEditingController carColorCtrl = TextEditingController(text: '');
  TextEditingController carPrefenceCtrl = TextEditingController(text: '');

  var phone = ''.obs;
  var password = ''.obs;
  var emailText = ''.obs;
  var fnText = ''.obs;
  var lnText = ''.obs;
  var confirmPassword = ''.obs;
  var phoneAndCode = ''.obs;
  var loading = false.obs;
  var otp = ''.obs;
  final ctrl = Get.put(GlobalController());

  //Register
  void signup() async {
    var data = {
      'firstName': fnText.value.trim(),
      'lastName': lnText.value.trim(),
      'phoneNumber': phone.value,
      'password': password.value,
      'email': emailText.value,
      'role': 2,
    };

    loading.value = true;
    var res = await Api().post(Endpoints.SIGN_UP, data);
    loading.value = false;

    if (res.respCode == 0) {
      AppAlert(
        message: res.respDesc,
        type: AlertType.SUCCESS,
      ).showAlert();

      Get.to(() => OtpPage());
    } else {
      AppAlert(message: res.respDesc).showAlert();
    }
  }

  //Verify Email
  void verifyOtp() async {
    var data = {
      "email": emailText.value,
      "code": otp.value,
    };

    loading.value = true;
    var res = await Api().post(Endpoints.VerifyEMAIL, data);
    loading.value = false;

    if (res.respCode == 0) {
      AppAlert(
        message: res.respDesc,
        type: AlertType.SUCCESS,
      ).showAlert();

      Get.to(() => UpdateCar());
    } else {
      AppAlert(message: res.respDesc).showAlert();
    }
  }

  //Resend otp
  void resendOtp(int type) async {
    var data = {
      'userEmail': emailText.value,
      'otptype': type
    };

    loading.value = true;
    var res = await Api().post(Endpoints.RESENDOTP, data);
    loading.value = false;

    if (res.respCode == 0) {
      AppAlert(
        message: res.respDesc,
        type: AlertType.SUCCESS,
      ).showAlert();

      Get.to(() => UpdatePassword());
    } else {
      AppAlert(message: res.respDesc).showAlert();
    }
  }

  //Verify Email passwor
  void verifyemail() async {
    var data = {
      "email": emailText.value,
      "code": otp.value,
    };

    loading.value = true;
    var res = await Api().post(Endpoints.VerifyEMAIL, data);
    loading.value = false;

    if (res.respCode == 0) {
      AppAlert(
        message: res.respDesc,
        type: AlertType.SUCCESS,
      ).showAlert();

      Get.to(() => UpdatePassword());
    } else {
      AppAlert(message: res.respDesc).showAlert();
    }
  }

  void forgetPassword() async {
    var data = {
      'password': password.value,
      'email': emailText.value,
    };

    loading.value = true;
    var res = await Api().post(Endpoints.FORGETPASSWORD, data);
    loading.value = false;

    if (res.respCode == 0) {
      AppAlert(
        message: res.respDesc,
        type: AlertType.SUCCESS,
      ).showAlert();

      Get.offAll(() => SignIn());
    } else {
      AppAlert(message: res.respDesc).showAlert();
    }
  }

  //Verify Email
  void forgetPasswordVerifyEmail() async {
    var data = {
      "email": emailText.value,
       "code": otp.value,
    };

    loading.value = true;
    var res = await Api().post(Endpoints.RESENDOTP, data);
    loading.value = false;

    if (res.respCode == 0) {
      AppAlert(
        message: res.respDesc,
        type: AlertType.SUCCESS,
      ).showAlert();

      Get.to(() => UpdatePassword());
    } else {
      AppAlert(message: res.respDesc).showAlert();
    }
  }

  //Add Car
  void addCar() async {
    var data = {
      "email": ctrl.email.text,
      "carMake": carMakeCtrl.text,
      "carModel": carModelCtrl.text,
      "carColor": carColorCtrl.text,
      "plateNumber": carPlateNumberCtrl.text,
      "typeOfVehicle": carTypeCtrl.text,
      "driverLiscense": driverLiscenseCtrl.text,
      "carPreferences": carPrefenceCtrl.text,
    };

    loading.value = true;
    var res = await Api().post(Endpoints.REGISTER_CAR, data);
    loading.value = false;

    if (res.respCode == 0) {
      Get.offAll(() => SignIn());

      AppAlert(
        message: res.respDesc,
        type: AlertType.SUCCESS,
      ).showAlert();
    } else {
      AppAlert(message: res.respDesc).showAlert();
    }
  }

   void verifyPasswordOtp() async {
    var data = {
      "email": emailText.value,
      "code": otp.value,
    };

    loading.value = true;
    var res = await Api().post(Endpoints.VerifyEMAIL, data);
    loading.value = false;

    if (res.respCode == 0) {
      AppAlert(
        message: res.respDesc,
        type: AlertType.SUCCESS,
      ).showAlert();

    } else {
      AppAlert(message: res.respDesc).showAlert();
    }
  }

  //Update Car
  void updateCar() async {
    var data = {
      "email": ctrl.email.text,
      "carMake": carMakeCtrl.text,
      "carModel": carModelCtrl.text,
      "carColor": carColorCtrl.text,
      "plateNumber": carPlateNumberCtrl.text,
      "typeOfVehicle": carTypeCtrl.text,
      "driverLiscense": driverLiscenseCtrl.text,
      "carPreferences": carPrefenceCtrl.text,
    };

    loading.value = true;
    var res = await Api().put(Endpoints.UPDATE_CAR, data);
    loading.value = false;

    if (res.respCode == 0) {
      Get.offAll(() => SignIn());
      AppAlert(
        message: res.respDesc,
        type: AlertType.SUCCESS,
      ).showAlert();
    } else {
      AppAlert(message: res.respDesc).showAlert();
    }
  }
}
