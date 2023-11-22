import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../theme/colors.dart';
import 'delete account/delete_account.dart';
import 'reset_password.dart';

class SecurityPage extends StatelessWidget {
  const SecurityPage({super.key});

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
          'Settings',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.PRIMARY_COLOR,
      ),
      body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Get.to(ResetPassword());
                },
                child: Container(
                  height: 50,
                  alignment: Alignment.center,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFF5F5F5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.lock),
                        SizedBox(
                          width: 14,
                        ),
                        Text(
                          'Reset Password',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ]),
                ),
              ),
              const SizedBox(height: 30),
                GestureDetector(
                onTap: () {
                  Get.to(DeleteAccount());
                },
                child: Container(
                  height: 50,
                  alignment: Alignment.center,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFF5F5F5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.person_2),
                        SizedBox(
                          width: 14,
                        ),
                        Text(
                          'Delete Account',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ]),
                ),
              ),
            
            ],
          )),
    );
  }
}
