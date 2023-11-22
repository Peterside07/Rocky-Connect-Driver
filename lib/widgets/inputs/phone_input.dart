import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:rockyconnectdriver/widgets/inputs/app_input.dart';

class PhoneInput extends StatelessWidget {
  final TextEditingController? controller;
  final String placeholder;
  final Function(CountryCode)? onChangedCode;
  final Function(String)? onChanged;

  const PhoneInput({super.key, 
    this.controller,
    this.placeholder = 'Phone number',
    this.onChangedCode,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 80,
          child: AppInput(
            controller: TextEditingController(text: '+234'),
            enabled: false,
          ),
        ),
   const   SizedBox(width: 12.0),
        Expanded(
          flex: 1,
          child: AppInput(
            placeholder: placeholder,
            controller: controller,
            keyboardType: TextInputType.phone,
            onChanged: onChanged,
            maxLength: 10,
          ),
        ),
      ],
    );
  }
}
