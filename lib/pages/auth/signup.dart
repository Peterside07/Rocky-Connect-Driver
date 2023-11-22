import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rockyconnectdriver/pages/auth/sign_in.dart';
import 'package:rockyconnectdriver/theme/colors.dart';

import '../../controllers/signup_controller.dart';
import '../../widgets/buttons/primary_button.dart';
import '../../widgets/inputs/app_input.dart';
import '../../widgets/inputs/password_input.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final ctrl = Get.put(SignupController());

  late String _password;
  double _strength = 0;

  RegExp numReg = RegExp(r".*[0-9].*");
  RegExp letterReg = RegExp(r".*[A-Za-z].*");

  void _checkPassword(String value) {
    _password = value.trim();

    if (_password.isEmpty) {
      setState(() {
        _strength = 0;
      });
    } else if (_password.length < 6) {
      setState(() {
        _strength = 1 / 4;
      });
    } else if (_password.length < 8) {
      setState(() {
        _strength = 2 / 4;
      });
    } else {
      if (!letterReg.hasMatch(_password) || !numReg.hasMatch(_password)) {
        setState(() {
          _strength = 3 / 4;
        });
      } else {
        setState(() {
          _strength = 1;
        });
      }
    }
  }

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
                          _checkPassword(val);
                          ctrl.password.value = val;
                        },
                      ),
                      LinearProgressIndicator(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        value: _strength,
                        backgroundColor: Colors.grey[300],
                        color: _strength <= 1 / 4
                            ? Colors.red
                            : _strength == 2 / 4
                                ? Colors.yellow
                                : _strength == 3 / 4
                                    ? Colors.blue
                                    : Colors.green,
                        minHeight: 7,
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
                              Get.to(() => SignIn());
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
