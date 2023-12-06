import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rockyconnectdriver/controllers/signup_controller.dart';
import 'package:rockyconnectdriver/theme/colors.dart';

import '../../widgets/buttons/primary_button.dart';
import '../../widgets/inputs/app_input.dart';
import '../account/account_page.dart';
import 'update_bank.dart';

class UpdateCar extends StatelessWidget {
  UpdateCar({super.key});

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
                      children: [
                        const Text(
                          'Car information',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                        AppInput(
                          placeholder: 'Driver Licence ID'.tr,
                          controller: ctrl.driverLiscenseCtrl,
                        ),
                        AppInput(
                          placeholder: 'Vehicle Maker'.tr,
                          controller: ctrl.carMakeCtrl,
                        ),
                        AppInput(
                          placeholder: 'Vehicle Model'.tr,
                        
                          controller: ctrl.carModelCtrl,
                        ),
                        AppInput(
                          placeholder: 'Type of Vehicle'.tr,
                          controller: ctrl.carTypeCtrl,
                       
                        ),
                        AppInput(
                          placeholder: 'Plate Number'.tr,
                          controller: ctrl.carPlateNumberCtrl,
                        ),
                        AppInput(
                          placeholder: 'Color of Vehicle'.tr,
                          controller: ctrl.carColorCtrl,
                        ),
                        CarPreferenceInput(
                          controller: ctrl.carPrefenceCtrl,
                          onValueChanged: (val) {
                            // profile.carTypeText.value = val;
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: Obx(
                                () => PrimaryButton(
                                  label: 'Save',
                                  isLoading: ctrl.loading.value,
                                  onPressed: () => ctrl.addCar(),
                                ),
                              ),
                            ),
                            Expanded(
                              child: PrimaryButton(
                                    label: 'Skip',
                                    onPressed: () {
                                      Get.to(() => UpdateBank());
                                    }
                              ),
                            )
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
