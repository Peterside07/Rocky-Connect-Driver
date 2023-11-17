import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:rockyconnectdriver/models/car_model.dart';
import 'package:rockyconnectdriver/widgets/utils.dart';

import '../global/endpoints.dart';
import '../models/app_alert.dart';
import '../models/user_model.dart';
import '../pages/home/home_screen.dart';
import '../services/api.dart';

class GlobalController extends GetxController {
  var barIndex = 0.obs;
  var tr = {}.obs;
  var token = ''.obs;
  var user = UserModel().obs;
  var car = CarModel().obs;
  TextEditingController oldPassword = TextEditingController(text: '');
  TextEditingController newPassword = TextEditingController(text: '');
  TextEditingController confirmPassword = TextEditingController(text: '');
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();

  TextEditingController carName = TextEditingController();
  TextEditingController carType = TextEditingController();
  TextEditingController carColor = TextEditingController();
  TextEditingController carModel = TextEditingController();

  TextEditingController plateNumber = TextEditingController();
  TextEditingController carPreferences = TextEditingController();
  TextEditingController driverLiscense = TextEditingController();

  TextEditingController email = TextEditingController();
  TextEditingController phoneCtrl = TextEditingController();
  var carList = <CarModel>[].obs;

  var isLoading = false.obs;
  var password = ''.obs;
  var loading = false.obs;
  var emailAddress = ''.obs;
  var oldPin = ''.obs;
  var newPin = ''.obs;
  var confirmPin = ''.obs;
  var phone = ''.obs;
  var emailText = ''.obs;
  var fnText = ''.obs;
  var lnText = ''.obs;
  var carNameText = ''.obs;
  var carTypeText = ''.obs;
  var carModelText = ''.obs;

  Rx<Position> userLocation = Position(
    accuracy: 0,
    altitude: 0,
    heading: 0,
    latitude: 37.42796133580664,
    longitude: -122.085749655962,
    speed: 0,
    speedAccuracy: 0,
    altitudeAccuracy: 0,
    headingAccuracy: 0,
    timestamp: DateTime.now(),
  ).obs;

  void validateFields() {
    if (oldPassword.text.isEmpty || newPassword.text.isEmpty) {
      Utils.showAlert('All fields are required'.tr);
      return;
    }
    if (newPassword.text != confirmPassword.text) {
      Utils.showAlert('password do not match'.tr);
      return;
    }
    changePassword();
  }

  void changePassword() async {
    var data = {
      "email": user.value.email,
      "newPassword": newPassword.text,
      "oldPassword": oldPassword.text,
    };

    loading.value = true;
    var response = await Api().post(Endpoints.RESETPASSWORD, data);
    loading.value = false;

    if (response.respCode == 0) {
      AppAlert(
        message: response.respDesc,
        type: AlertType.SUCCESS,
      ).showAlert();
      Get.to(() => HomeScreen());
    } else {
      Utils.showAlert(response.respDesc);
    }
  }

  void setUserLocation(Position location) {
    userLocation.value = location;
  }

  void setFieldsForEdit() {
    phoneCtrl.text = user.value.phoneNumber ?? '';
    email.text = user.value.email ?? '';
    firstName.text = user.value.firstName ?? '';
    lastName.text = user.value.lastName ?? '';
  }

  void setCarForEdit() {
    carName.text = car.value.carMake ?? '';
    carColor.text = car.value.carColor ?? '';
    carModel.text = car.value.carModel ?? '';
    carType.text = car.value.typeOfVehicle ?? '';
    plateNumber.text = car.value.plateNumber ?? '';
    driverLiscense.text = car.value.driverLiscense ?? '';
   // carPreferences.text = car.value.carPreferences ?? '';
  }

  void getCar() async {
    final email = ctrl.email.text;
    String encodedEmail = Uri.encodeComponent(email);

    loading.value = true;
    var res = await Api().get(
      '${Endpoints.GET_CAR}?email=$encodedEmail',
    );
    loading.value = false;

    if (res.respCode == 0) {
      car.value = CarModel.fromJson(res.data);
      setCarForEdit();
    } else {
      AppAlert(message: res.respDesc).showAlert();
    }
  }

//Update Account
  void updateAccount() async {
    var data = {
      'firstName': firstName.text,
      'lastName': lastName.text,
      'phoneNumber': phoneCtrl.text,
      "password": "123456",
      "email": user.value.email
    };

    loading.value = true;
    var res = await Api().put(Endpoints.UPDATE_ACCOUNT, data);
    loading.value = false;

    if (res.respCode == 0) {
      //  getUserInfo();
      AppAlert(
        message: res.respDesc,
        type: AlertType.SUCCESS,
      ).showAlert();

      Get.to(() => HomeScreen());
    } else {
      AppAlert(message: res.respDesc).showAlert();
    }
  }

//Update Car
  void updateCar() async {
    var data = {
      "email": "string",
      "carMake": carName.text,
      "carModel": carModel.text,
      "carColor": carColor.text,
      "plateNumber": plateNumber.text,
      "typeOfVehicle": carType.text,
      "driverLiscense": driverLiscense.text,
      "carPreferences": carPreferences.text,
    };

    loading.value = true;
    var res = await Api().put(Endpoints.SIGN_UP, data);
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
