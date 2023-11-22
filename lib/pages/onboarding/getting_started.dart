import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rockyconnectdriver/theme/colors.dart';

import '../../services/storage.dart';
import '../../widgets/buttons/primary_button.dart';
import '../auth/signup.dart';

class GettingStartedPage extends StatelessWidget {
  const GettingStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.PRIMARY_COLOR,
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 320.0),
            child: Center(
              child: Text(
                "Rocky Connect",
                style: GoogleFonts.tourney(fontSize: 45, color: Colors.white),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          PrimaryButton(
            buttonColor: const Color(0xFFE4CAFF),
            label: 'Get Started',
            textSize: 24,
            textColor: AppColors.PRIMARY_COLOR,
            onPressed: () {
              StorageService().saveViewedWalkthrough();

              Get.to(() => const SignUp());
            },
          ),
        ],
      ),
    );
  }
}
