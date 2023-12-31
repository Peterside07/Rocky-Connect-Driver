// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../theme/colors.dart';

class AppLoader extends StatelessWidget {
  final String message;
  final bool isLoading;
  final Widget child;

  const AppLoader({super.key, this.message = '', this.isLoading = false, required this.child});

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: isLoading,
      opacity: 1,
      color: Get.isDarkMode
          ? const Color.fromRGBO(0, 0, 0, 0.9)
          : const Color.fromRGBO(255, 255, 255, 0.9),
      progressIndicator: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.PRIMARY_COLOR,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    message.isNotEmpty ? message : '${'please wait'.tr}...',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.copyWith(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      child: child,
    );
  }
}
