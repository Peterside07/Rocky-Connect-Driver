// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


import '../../controllers/login_controller.dart';
import '../../theme/colors.dart';
import '../../widgets/buttons/primary_button.dart';
import '../../widgets/inputs/app_input.dart';
import '../../widgets/inputs/password_input.dart';
import 'forget password/forget_password.dart';
import 'signup.dart';

class SignIn extends StatelessWidget {
  SignIn({super.key});

  final ctrl = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.purple[800],
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 220.0,
                bottom: 80,
              ),
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
                height: 900,
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
                        'Log In',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      AppInput(
                        textCapitalization: TextCapitalization.none,
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: const Icon(
                          Icons.mail,
                        ),
                        placeholder: 'Enter your email',
                        controller: ctrl.emailCtx,
                        onChanged: (val) {
                          ctrl.emailAddress.value = val;
                        },
                      ),
                      PasswordInput(
                        placeholder: ' Enter your password',
                        controller: ctrl.passwordCtx,
                        onChanged: (val) {
                          ctrl.password.value = val;
                        },
                      ),
                      Obx(
                        () => PrimaryButton(
                            isLoading: ctrl.isLoading.value,
                            label: 'Login',
                            onPressed: ctrl.emailAddress.value.isEmpty ||
                                    ctrl.password.value.isEmpty
                                ? null
                                : () => ctrl.userLogin()),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => ForgetPassword());
                        },
                        child: Text("Forgot Password?"),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have an account?",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => SignUp());
                            },
                            child: const Text(
                              "Sign Up",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: AppColors.PRIMARY_COLOR,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40)
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
