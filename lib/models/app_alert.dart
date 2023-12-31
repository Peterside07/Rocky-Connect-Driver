// ignore_for_file: constant_identifier_names, deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rockyconnectdriver/theme/colors.dart';

import '../../controllers/global_controller.dart';

enum AlertType { ERROR, SUCCESS, INFO }

class AppAlert extends StatelessWidget {
  final String title;
  final String message;
  final AlertType type;

  final globalCtx = Get.put(GlobalController());

  AppAlert({super.key, 
    this.title = '',
    required this.message,
    this.type = AlertType.ERROR,
  });

  final textStyle = const TextStyle(fontWeight: FontWeight.w700);

  String getTitle() {
    switch (type) {
      case AlertType.INFO:
        return 'info'.tr;
      case AlertType.SUCCESS:
        return 'success'.tr;
      case AlertType.ERROR:
        return 'error'.tr;
    }
  }

  void showAlert() {
    Get.showSnackbar(
      GetBar(
        backgroundColor: type == AlertType.ERROR
            ? Colors.red
            : type == AlertType.INFO
                ? AppColors.PRIMARY_COLOR
                : Colors.green,
        title: title.isEmpty ? getTitle() : title,
        icon: const Icon(Icons.error_outline_rounded),
        duration: const Duration(seconds: 3),
        snackPosition: SnackPosition.BOTTOM,
        isDismissible: true,
        onTap: (obj) => Get.back(),
        message: message,
        messageText: Text(message, style: const TextStyle(color: Colors.white) ),
        
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? AlertDialog(
            title: Text(
              title.isEmpty ? 'error'.tr : title,
            ),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Get.back(),
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(
                    AppColors.PRIMARY_COLOR,
                  ),
                ),
                child: Text(
                  'ok'.tr,
                  style: textStyle.copyWith(color: AppColors.PRIMARY_COLOR),
                ),
              )
            ],
          )
        : CupertinoAlertDialog(
            title: Text(title.isEmpty ? 'error'.tr : title),
            content: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                message,
              ),
            ),
            actions: [
              CupertinoButton(
                child: Text('ok'.tr, style: textStyle),
                onPressed: () => Get.back(),
              )
            ],
          );
  }
}
