import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rockyconnectdriver/theme/colors.dart';

import '../../controllers/signup_controller.dart';
import '../../widgets/buttons/primary_button.dart';
import '../../widgets/inputs/app_input.dart';
import 'sign_in.dart';

class UpdateBank extends StatelessWidget {
  UpdateBank({super.key});

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
              height: 40,
            ),
            Center(
              child: Container(
                // height: 600,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40)),
                    color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Center(
                          child: Text(
                            'Account Information',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Account Bank",
                          style: GoogleFonts.poppins(
                            fontSize: 17,
                            color: Colors.grey,
                          ),
                        ),
                        AppInput(
                          controller: ctrl.acctName,
                        ),
                        Text(
                          "Account number ",
                          style: GoogleFonts.poppins(
                            fontSize: 17,
                            color: Colors.grey,
                          ),
                        ),
                        AppInput(
                          controller: ctrl.acctNumber,
                          keyboardType: TextInputType.number,
                        ),
                        Text(
                          "Routing Number",
                          style: GoogleFonts.inter(
                            fontSize: 17,
                            color: Colors.grey,
                          ),
                        ),
                        AppInput(
                          controller: ctrl.routeNumber,
                          keyboardType: TextInputType.number,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: Obx(
                                () => PrimaryButton(
                                  label: 'Save',
                                  isLoading: ctrl.loading.value,
                                  onPressed: () => ctrl.addBank(),
                                ),
                              ),
                            ),
                            Expanded(
                              child: PrimaryButton(
                                  label: 'Skip',
                                  onPressed: () {
                                    Get.offAll(() => SignIn());
                                  }),
                            ),
                          ],
                        ),
                      ],
                    ),
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
