import 'dart:convert';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:rockyconnectdriver/global/config.dart';
import 'package:rockyconnectdriver/models/api_response.dart';
import 'package:rockyconnectdriver/services/token.dart';
import 'package:rockyconnectdriver/services/util_service.dart';

class Api {
  late Dio dio;

  Api() {
    BaseOptions options = BaseOptions(
      baseUrl: AppConfig.BASE_URL,
      connectTimeout: 60000,
    );

    dio = Dio(options);

    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) {
        return true;
      };
      return null;
    };
  }

  Future<void> setHeader() async {
    dio.options.headers.addAll({'content-type': 'application/json'});

    var token = TokenService.token;
    if (token.isNotEmpty) {
      dio.options.headers.addAll({'Authorization': 'Bearer $token'});
    }
  }

  Future<ApiResponse> post(String endpoint, dynamic data) async {
    return await _request(endpoint, method: 'post', data: data);
  }

  Future<ApiResponse> put(String endpoint, dynamic data) async {
    return await _request(endpoint, method: 'put', data: data);
  }

  Future<ApiResponse> get(String endpoint, ) async {
    return await _request(endpoint, method: 'get');
  }

  Future<ApiResponse> delete(String endpoint, dynamic data) async {
    return await _request(endpoint, method: 'delete', data: data);
  }

  Future<ApiResponse> _request(
    String endpoint, {
    required String method,
    dynamic data,
  }) async {
    await setHeader();
    print(AppConfig.BASE_URL + endpoint);
    print(jsonEncode(data));

    try {
      var response = await dio.request(
        endpoint,
        data: data,
        options: Options(method: method),
      );
     print(endpoint);
      print(data);
      debugPrint(response.toString());

      if (response.data.runtimeType == List) {
        return ApiResponse({
          'respCode': 0,
          'respDesc': 'success'.tr,
          'body': response.data,
        });
      }

      try {
        return ApiResponse(response.data);
      } catch (e) {
        return ApiResponse(
          {'respCode': 0, 'respDesc': 'success'.tr, 'data': response.data},
        );
      }
    } on DioError catch (err) {
      print('ERROR');
      print(endpoint);
      print(err);
      print(err.response);

      if (err.type == DioErrorType.connectTimeout) {
        return ApiResponse(
          {
            'respCode': 99,
            'respDesc': 'timed_out'.tr,
            'data': {'body': ''}
          },
        );
      }

      if (err.response?.statusCode == 401) {
      //  Get.offAll(() => Signin());
       // StorageService().removeToken();
        return ApiResponse(err.response?.data);
      }

      if ((err.response?.statusCode ?? 0) >= 400 &&
          err.response?.data.runtimeType == String) {
        return ApiResponse(
          {
            'respCode': err.response?.statusCode,
            'respDesc':
                UtilService.statusCodeToMessage(err.response?.statusCode),
            'data': {'body': err.response?.data}
          },
        );
      }

      return ApiResponse(err.response?.data);
    }
  }
}
