import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rockyconnectdriver/widgets/buttons/primary_button.dart';
import 'package:rockyconnectdriver/widgets/inputs/app_input.dart';

import '../../theme/colors.dart';
import 'reset_password.dart';

class SecurityPage extends StatelessWidget {
  const SecurityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(         centerTitle: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(40),
        )),
        title: const Text(
          'Settings',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.PRIMARY_COLOR,
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Enter Password',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF68727C),
                  fontSize: 24,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  height: 0,
                ),
              ),
              AppInput(

              ),
              PrimaryButton(
                onPressed: (){
                  Get.offAll(ResetPassword());
                },
                label: 'Next',
              )
            ],
          )),
    );
  }
}
