import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../controllers/global_controller.dart';
import '../../../theme/colors.dart';
import '../../../widgets/buttons/primary_button.dart';
import '../../../widgets/inputs/app_input.dart';

class DeleteAccount extends StatelessWidget {
  DeleteAccount({super.key});
  final ctrl = Get.put(GlobalController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.PRIMARY_COLOR_LIGHT,
      appBar: AppBar(
                centerTitle: true,

        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(40),
        )),
        title: const Text(
          'Delete Account',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.PRIMARY_COLOR,
      ),
      body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            //    mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'we are sad to see you go...',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w300,
                ),
              ),
            Container(
                height: 114,
                child: const AppInput(
                  prefixIcon: Icon(Icons.lock),
                  placeholder: 'Tell us why you want to go...',
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 50),
              AppInput(
                color: Colors.white,
                placeholder: 'Enter your email ',
               controller: ctrl.email,
              ),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  "Rocky Connect",
                  style: GoogleFonts.tourney(fontSize: 45, color: Colors.white),
                ),
              ),
              Obx(
                () => PrimaryButton(
                  label: 'Delete',
                  isLoading: ctrl.loading.value,
                  onPressed: ctrl.deleteAccount,
                ),
              )
            ],
          )),
    );
  }
}
