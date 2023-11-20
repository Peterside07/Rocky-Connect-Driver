import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rockyconnectdriver/pages/auth/sign_in.dart';
import 'package:rockyconnectdriver/theme/colors.dart';

import '../../controllers/signup_controller.dart';
import '../../widgets/buttons/primary_button.dart';
import '../../widgets/inputs/app_input.dart';
import '../../widgets/inputs/password_input.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});

  final ctrl = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: AppColors.PRIMARY_COLOR,
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 100.0),
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
            Center(
              child: Container(
                height: 600,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40)),
                    color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      const Text(
                        'Welcome',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                      AppInput(
                        placeholder: 'Please Enter your first name'.tr,
                        onChanged: (val) => ctrl.fnText.value = val,
                        controller: ctrl.fnCtrl,
                      ),
                      AppInput(
                        placeholder: 'Please Enter your second name'.tr,
                        onChanged: (val) => ctrl.lnText.value = val,
                        controller: ctrl.lnCtrl,
                      ),
                      AppInput(
                        placeholder: 'Please Enter your email'.tr,
                        onChanged: (val) {
                          ctrl.emailText.value = val;
                        },
                        controller: ctrl.emailCtrl,
                        keyboardType: TextInputType.emailAddress,
                        textCapitalization: TextCapitalization.none,
                      ),
                      AppInput(
                        placeholder: 'Enter your Phone numbers'.tr,
                        controller: ctrl.phoneCtrl,
                        onChanged: (val) {
                          ctrl.phone.value = val;
                        },
                        keyboardType: TextInputType.number,
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
                          label: 'Sign Up',
                          isLoading: ctrl.loading.value,
                          onPressed: () => ctrl.signup(),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Already have an account?",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(() =>  SignIn());
                            },
                            child: const Text(
                              "Log in",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: AppColors.PRIMARY_COLOR,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
