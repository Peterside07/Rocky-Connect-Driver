import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rockyconnectdriver/global/endpoints.dart';
import 'package:rockyconnectdriver/otp.dart';
import 'package:rockyconnectdriver/pages/auth/forget%20password/update_password.dart';
import 'package:rockyconnectdriver/pages/auth/signIn.dart';
import 'package:rockyconnectdriver/services/api.dart';

import '../models/app_alert.dart';

class SignupController extends GetxController {
  TextEditingController phoneCtrl = TextEditingController(text: '');
  TextEditingController passwordCtrl = TextEditingController(text: '');
  TextEditingController confirmPasswordCtrl = TextEditingController(text: '');
  TextEditingController otpCtrl = TextEditingController(text: '');
  TextEditingController fnCtrl = TextEditingController(text: '');
  TextEditingController lnCtrl = TextEditingController(text: '');
  TextEditingController emailCtrl = TextEditingController(text: '');

  var phone = ''.obs;
  var password = ''.obs;
  var emailText = ''.obs;
  var fnText = ''.obs;
  var lnText = ''.obs;
  var confirmPassword = ''.obs;
  var phoneAndCode = ''.obs;
  var loading = false.obs;
  var otp = ''.obs;

  //Register
  void signup() async {
    var data = {
      'firstName': fnText.value.trim(),
      'lastName': lnText.value.trim(),
      'phoneNumber': phone.value,
      'password': password.value,
      'email': emailText.value,
      'role': 1,
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

      Get.to(() => SignIn());
    } else {
      AppAlert(message: res.respDesc).showAlert();
    }
  }

  //Resend otp
   void resendOtp() async {
    var data = {
      'email': emailText.value,
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
  void forgetPasswordVerifyEmail() async {
    var data = {
      "email": emailText.value,
     // "code": otp.value,
    };

    loading.value = true;
    var res = await Api().post(Endpoints.RESENTOTP, data);
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
}
