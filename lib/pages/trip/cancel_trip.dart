// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/trip_controller.dart';
import '../../models/trip_response.dart';
import '../../theme/colors.dart';
import '../../widgets/buttons/primary_button.dart';

class CancelTrip extends StatefulWidget {
  final TripResponse tripResponse;

  const CancelTrip({
    Key? key,
    required this.tripResponse,
  }) : super(key: key);

  @override
  State<CancelTrip> createState() => _CancelTripState();
}

class _CancelTripState extends State<CancelTrip> {
  final ctrl = Get.put(TripController());
  String selectedReason = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.PRIMARY_COLOR_LIGHT,
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 24.0),
          child: Obx(
            () => PrimaryButton(
                label: 'Done',
                isLoading: ctrl.loading.value,
                onPressed: () {
                  ctrl.cancelATripWithReason(
                      widget.tripResponse.id ?? '', selectedReason);
                }),
          ),
        ),
        appBar: AppBar(
                  centerTitle: true,

          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(40),
          )),
          title: const Text(
            'Cancel Trip',
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          backgroundColor: AppColors.PRIMARY_COLOR,
        ),
        body: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Center(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 16),
                    _buildReasonToggleButton('Unknown vehicle'),
                    _buildReasonToggleButton("Customer didn't show up"),
                    _buildReasonToggleButton('Reschedule date'),
                    _buildReasonToggleButton('Customer was rude'),
                  ]),
            )));
  }

  Widget _buildReasonToggleButton(String reason) {
    return ListTile(
      title: Text(
        reason,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
        ),
      ),
      leading: Radio<String>(
        value: reason,
        groupValue: selectedReason,
        onChanged: (String? value) {
          setState(() {
            selectedReason = value!;
          });
        },
      ),
    );
  }
}
