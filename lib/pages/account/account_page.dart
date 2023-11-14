import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rockyconnectdriver/controllers/global_controller.dart';
import 'package:rockyconnectdriver/theme/colors.dart';
import 'package:rockyconnectdriver/widgets/inputs/app_input.dart';

import '../../widgets/buttons/primary_button.dart';

class AccountPage extends StatelessWidget {
  AccountPage({super.key});
  final profile = Get.put(GlobalController());

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
          'Account',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.PRIMARY_COLOR,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Container(
            //   width: 430,
            //   height: 140,
            //   decoration: const ShapeDecoration(
            //     color: Color(0xFF663399),
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.only(
            //         bottomLeft: Radius.circular(50),
            //         bottomRight: Radius.circular(50),
            //       ),
            //     ),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "First name",
                    style: GoogleFonts.poppins(
                      fontSize: 17,
                      color: Colors.grey,
                    ),
                  ),
                  AppInput(
                    controller: profile.firstName,
                    onChanged: (val) => profile.fnText.value = val,
                  ),
                  Text(
                    "Last name",
                    style: GoogleFonts.poppins(
                      fontSize: 17,
                      color: Colors.grey,
                    ),
                  ),
                  AppInput(
                    controller: profile.lastName,
                    onChanged: (val) => profile.lnText.value = val,
                  ),
                  Text(
                    "Email Address",
                    style: GoogleFonts.inter(
                      fontSize: 17,
                      color: Colors.grey,
                    ),
                  ),
                  AppInput(
                    enabled: false,
                    controller: profile.email,
                  ),
                  Text(
                    "Phone Number",
                    style: GoogleFonts.inter(
                      fontSize: 17,
                      color: Colors.grey,
                    ),
                  ),
                  AppInput(
                    controller: profile.phoneCtrl,
                    onChanged: (val) {
                      profile.phone.value = val;
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Obx(
                      () => PrimaryButton(
                        label: 'Save changes',
                        isLoading: profile.loading.value,
                        onPressed: () => profile.updateAccount(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
