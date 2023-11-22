import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app_input.dart';

class PasswordInput extends StatefulWidget {
  final String placeholder;
  final TextEditingController? controller;
  final Function(String)? onChanged;

  const PasswordInput({
    Key? key,
    this.placeholder = 'enter_password',
    this.controller,
    this.onChanged,
  }) : super(key: key);

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool hideText = true;

  void onToggle() {
    setState(() {
      hideText = !hideText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppInput(
      placeholder: widget.placeholder.tr,
      color: Colors.white,
                      prefixIcon: const Icon(Icons.lock),

      suffixIcon: GestureDetector(
        onTap: onToggle,
        child: Text(
          hideText ? 'show'.tr : 'hide'.tr,
          style: TextStyle(
            color: Get.isDarkMode ? Colors.white : const Color(0xff011405),
          ),
        ),
      ),
      hideText: hideText,
      textCapitalization: TextCapitalization.none,
      onChanged: widget.onChanged,
      controller: widget.controller,
    );
  }
}
