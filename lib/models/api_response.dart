// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class ApiResponse {
  int? respCode;
  String respDesc = 'Something went wrong';
  dynamic data;

  ApiResponse(dynamic data) {
    int code = 99;
    var dataBody;

    if (data.runtimeType == String) {
      respDesc = data;
      return;
    }

    if (data.keys.contains('statusCode') && data['statusCode'] == '00') {
      code = 0;
    }

    if (data.keys.contains('token')) {
      code = 0;
      dataBody = data;
    }

    // if (data.keys.contains('message')) {
    //   code = 0;
    // }

    dataBody = data;

    //  if (data.keys.contains('message')) {
    //   dataBody = data['message'];
    // }

    if (data.keys.contains('respCode')) {
      code = data['respCode'];
    }

    if (data.keys.contains('body')) {
      debugPrint('body');
      dataBody = data['body'];
    }

    if (data.keys.contains('data')) {
      debugPrint('data');
      dataBody = data['data'];
    }

    respCode = code;
    this.data = dataBody;
    respDesc = data['status'] ?? '';
  }
}
