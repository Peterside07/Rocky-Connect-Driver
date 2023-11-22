import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../widgets/buttons/primary_button.dart';
import '../../controllers/signup_controller.dart';
import '../../theme/colors.dart';
import '../home/home_screen.dart';

class RefundTrip extends StatelessWidget {
  RefundTrip({super.key});

  final ctrl = Get.put(SignupController());

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
          'Cancel Trip',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.PRIMARY_COLOR,
      ),
      backgroundColor: AppColors.PRIMARY_COLOR_LIGHT,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 123,
              width: 123,
              child: Image.asset('assets/images/doneimage.png'),
            ),
            const SizedBox(height: 10),
            const Text(
              'Trip successfully completed',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 10),

            /**For the Rocky Connect */
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: Text(
                  "Rocky Connect",
                  style: GoogleFonts.tourney(fontSize: 45, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            PrimaryButton(
              label: 'Done',
              isLoading: ctrl.loading.value,
              onPressed: () {
                Get.offAll(() => const HomeScreen());
              },
            ),
          ],
        ),
      ),
    );
  }
}
