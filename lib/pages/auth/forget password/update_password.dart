import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../controllers/signup_controller.dart';
import '../../../theme/colors.dart';
import '../../../widgets/buttons/primary_button.dart';
import '../../../widgets/inputs/app_input.dart';
import '../../../widgets/inputs/password_input.dart';

class UpdatePassword extends StatelessWidget {
  UpdatePassword({super.key});

  final ctrl = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(40),
        )),
        title: const Text(
          'Forget Password? ',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.PRIMARY_COLOR,
      ),
      backgroundColor: AppColors.PRIMARY_COLOR_LIGHT,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 15.0),
              child: Text(
                "Enter the OTP code",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            AppInput(
              color: Colors.white,
              placeholder: '5 6 7 8 5 9',
              controller: ctrl.otpCtrl,
              onChanged: (val) {
                ctrl.otp.value = val;
                if (val.length == 6) ctrl.verifyPasswordOtp();
              },
              keyboardType: TextInputType.number,
            ),
            const Text(
              "Enter new New Password",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            PasswordInput(
              placeholder: 'Please Enter your password'.tr,
              controller: ctrl.passwordCtrl,
              onChanged: (val) {
                ctrl.password.value = val;
              },
            ),
            Obx(
              () => PrimaryButton(
                label: 'Send',
                isLoading: ctrl.loading.value,
                onPressed: () => ctrl.forgetPassword(),
              ),
            ),
            /**For the Rocky Connect */
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: Text(
                  "Rocky Connect",
                  style: GoogleFonts.tourney(fontSize: 45, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              height: 80,
            ),
          ],
        ),
      ),
    );
  }
}
