import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


import '../../controllers/global_controller.dart';
import '../../theme/colors.dart';
import '../../widgets/buttons/primary_button.dart';
import '../../widgets/inputs/app_input.dart';
import '../../widgets/inputs/password_input.dart';

class ResetPassword extends StatelessWidget {
  ResetPassword({super.key});
  final ctrl = Get.put(GlobalController());
  //final globalCtx = Get.put(GlobalController());

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
          'Reset Password',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.PRIMARY_COLOR,
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              AppInput(
                enabled: false,
                prefixIcon: const Icon(Icons.lock),
                placeholder: ctrl.user.value.email,
                color: Colors.white,
              ),
              PasswordInput(
                placeholder: 'Enter old password',
                controller: ctrl.oldPassword,
              ),
              PasswordInput(
                placeholder: 'Enter new password ',
                controller: ctrl.newPassword,
              ),
              PasswordInput(
                placeholder: 'Confirm new password',
                controller: ctrl.confirmPassword,
              ),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  "Rocky Connect",
                  style: GoogleFonts.tourney(fontSize: 45, color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
              Obx(
                () => Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: PrimaryButton(
                    label: 'Send',
                    isLoading: ctrl.loading.value,
                    onPressed: ctrl.validateFields
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
