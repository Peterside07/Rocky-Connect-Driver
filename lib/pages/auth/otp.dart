import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/signup_controller.dart';
import '../../widgets/buttons/primary_button.dart';
import '../../widgets/inputs/app_input.dart';

class OtpPage extends StatelessWidget {
  OtpPage({super.key});

  final ctrl = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.purple[800],
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 120.0),
              child: Center(
                child: Text(
                  "Rocky Connect",
                  style: GoogleFonts.tourney(fontSize: 47, color: Colors.white),
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
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 35.0),
                      child: Text(
                        "Hello ${ctrl.fnText.value}, Nice to meet you",
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 15.0),
                      child: Text(
                        "Enter the OTP code below",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:18.0, right: 18),
                      child: AppInput(
                        placeholder: '5 6 7 8 5 8 9',
                        controller: ctrl.otpCtrl,
                        onChanged: (val) {
                          ctrl.otp.value = val;
                        },
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    Obx(
                      () => PrimaryButton(
                        label: 'Verify',
                        isLoading: ctrl.loading.value,
                        onPressed: () => ctrl.verifyOtp(),
                      ),
                    ),
                    // GestureDetector(
                    //   onTap: () {
                    //     Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (context) => DifferentNum()));
                    //   },
                    //   child:  Text("Change phone number?"),
                    // ),

                    const Padding(
                      padding: EdgeInsets.all(60.0),
                      child: Text(
                        "By creating an account, you are agree to our terms of service and privacy policy.",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
