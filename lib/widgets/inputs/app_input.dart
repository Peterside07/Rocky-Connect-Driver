// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../theme/colors.dart';

class AppInput extends StatelessWidget {
  final String? placeholder;
  final TextEditingController? controller;
  final bool enabled;
  final TextCapitalization textCapitalization;
  final TextInputType keyboardType;
  final String? suffixText;
  final Widget? prefix;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Function(String)? onChanged;
  final int? maxLength;
  final bool hideText;
  final List<TextInputFormatter>? inputFormatters;
  final bool isTextArea;
  final String? helperText;
  final String? errorText;
  final double bottomMargin;
  final Color? color;

  const AppInput({
    Key? key,
    this.placeholder = '',
    this.controller,
    this.enabled = true,
    this.textCapitalization = TextCapitalization.words,
    this.keyboardType = TextInputType.text,
    this.suffixText,
    this.prefix,
    this.suffixIcon,
    this.prefixIcon,
    this.onChanged,
    this.maxLength,
    this.hideText = false,
    this.inputFormatters,
    this.isTextArea = false,
    this.helperText,
    this.errorText,
    this.bottomMargin = 10,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isTextArea ? null : 55,
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: color,
          border: Border.all(
            color: AppColors.PLACEHOLDER_COLOR,
          ),
          borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.only(bottom: bottomMargin, top: bottomMargin),
      child: TextField(
        enabled: enabled,
        textCapitalization: textCapitalization,
        keyboardType: keyboardType,
        controller: controller,
        onChanged: onChanged,
        maxLength: maxLength,
        obscureText: hideText,
        autocorrect: false,
        inputFormatters: inputFormatters,
        maxLines: isTextArea ? 4 : 1,
        decoration: InputDecoration(
          contentPadding: isTextArea
              ? const EdgeInsets.symmetric(vertical: 20, horizontal: 15)
              : const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
          hintText: '$placeholder',
          counterText: '',
          helperText: helperText,
          errorText: errorText,
          labelStyle: TextStyle(
              color: Get.isDarkMode
                  ? AppColors.INPUT_BG_COLOR
                  : AppColors.TEXT_COLOR),
          hintStyle: const TextStyle(
            color: AppColors.PLACEHOLDER_COLOR,
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(6),
          ),
          suffixText: suffixText,
          suffixStyle: TextStyle(
            color: Get.isDarkMode
                ? AppColors.INPUT_BG_COLOR
                : AppColors.DARK_COLOR,
          ),
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          prefix: prefix,
        ),
        style: TextStyle(
          fontSize: 18,
          color:
              Get.isDarkMode ? AppColors.INPUT_BG_COLOR : AppColors.DARK_COLOR,
          fontWeight: FontWeight.w600,
        ),
        cursorColor: AppColors.PRIMARY_COLOR,
      ),
    );
  }
}
