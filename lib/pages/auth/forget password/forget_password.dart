import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../controllers/signup_controller.dart';
import '../../../theme/colors.dart';
import '../../../widgets/buttons/primary_button.dart';
import '../../../widgets/inputs/app_input.dart';

class ForgetPassword extends StatelessWidget {
  ForgetPassword({super.key});

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
          'Forgot Password?',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.PRIMARY_COLOR,
      ),
      backgroundColor: AppColors.PRIMARY_COLOR_LIGHT,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ListView(
          children: [
            const Text(
              "Enter your email address",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            AppInput(
              color: Colors.white,
              placeholder: 'Please Enter your email',
              onChanged: (val) {
                ctrl.emailText.value = val;
              },
              controller: ctrl.emailCtrl,
              keyboardType: TextInputType.emailAddress,
              textCapitalization: TextCapitalization.none,
              prefixIcon: const Icon(
                Icons.email,
                // color: Colors.black,
              ),
            ),
            Obx(
              () => PrimaryButton(
                label: 'Send',
                isLoading: ctrl.loading.value,
                onPressed: () => ctrl.resendOtp(1),
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
