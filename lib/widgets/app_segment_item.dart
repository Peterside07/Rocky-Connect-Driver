// ignore_for_file: deprecated_member_use, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme/colors.dart';
class AppSegmentItem extends StatelessWidget {
  final String text;
  final String? value;
  final String? selectedValue;
  final double? height;
  final TextStyle activeText;
  final TextStyle? inactiveText;
  final double activeTextSize;
  final double inactiveTextSize;
  final double? textSize;

  const AppSegmentItem(
    this.text, {super.key, 
    this.value,
    this.selectedValue,
    this.height,
    this.activeText = const TextStyle(
      color: AppColors.PRIMARY_COLOR,
      fontWeight: FontWeight.w600,
    ),
    this.inactiveText,
    this.activeTextSize = 14,
    this.inactiveTextSize = 13,
    this.textSize,
  });

  @override
  Widget build(BuildContext context) {
    final TextStyle? _inactiveText =
        Theme.of(context).textTheme.headline1?.copyWith(
              fontSize: textSize ?? inactiveTextSize,
              fontWeight: FontWeight.w600,
            );

    return SizedBox(
      height: height ?? 32,
      width: double.infinity,
      child: Card(
        elevation: value == selectedValue ? 4.0 : 0.0,
        margin: const EdgeInsets.all(1.0),
        color: selectedValue == value
            ? Get.isDarkMode
                ? AppColors.DARK_BG_COLOR
                : Colors.white
            : Colors.transparent,
        shadowColor: const Color.fromRGBO(0, 0, 0, 0.8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        child:  SizedBox(
          child: Center(
            child: Text(
              text,
              style: selectedValue == value
                  ? activeText.copyWith(fontSize: textSize ?? activeTextSize)
                  : inactiveText ?? _inactiveText,
            ),
          ),
        ),
      ),
    );
  }
}
