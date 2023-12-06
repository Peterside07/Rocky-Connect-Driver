// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rockyconnectdriver/controllers/global_controller.dart';
import 'package:rockyconnectdriver/theme/colors.dart';
import 'package:rockyconnectdriver/widgets/inputs/app_input.dart';

import '../../widgets/app_segment_item.dart';
import '../../widgets/buttons/primary_button.dart';
import '../../widgets/inputs/number_input.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final profile = Get.put(GlobalController());

  String segment = 'profile';

  void onValueChanged(val) {
    setState(() {
      segment = val as String;
    });
  }

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
          'Account',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.PRIMARY_COLOR,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: double.infinity,
                  child: CupertinoSlidingSegmentedControl(
                    children: {
                      'profile': AppSegmentItem(
                        'Profile',
                        value: 'profile',
                        height: 50,
                        textSize: 16,
                        selectedValue: segment,
                      ),
                      'car': AppSegmentItem(
                        'Car profile',
                        value: 'car',
                        height: 50,
                        textSize: 16,
                        selectedValue: segment,
                      ),
                    },
                    onValueChanged: onValueChanged,
                  ),
                ),
                segment == 'profile'
                    ? Padding(
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
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
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
                      )
                    : Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Driver Licence ID",
                              style: GoogleFonts.inter(
                                fontSize: 17,
                                color: Colors.grey,
                              ),
                            ),
                            AppInput(
                               controller: profile.driverLiscense,
                            ),
                            Text(
                              "Car name",
                              style: GoogleFonts.poppins(
                                fontSize: 17,
                                color: Colors.grey,
                              ),
                            ),
                            AppInput(
                              controller: profile.carName,
                            ),
                            Text(
                              "Car model",
                              style: GoogleFonts.poppins(
                                fontSize: 17,
                                color: Colors.grey,
                              ),
                            ),
                            AppInput(
                              controller: profile.carModel,
                            ),
                            Text(
                              "Car type",
                              style: GoogleFonts.poppins(
                                fontSize: 17,
                                color: Colors.grey,
                              ),
                            ),
                            CarInput(
                                placeholder: '',
                      onValueChanged: (val) {
                       profile.carType.text = val;
                      profile.carRequiredString.value = val;
                      },
                      controller: profile.carType,
                            ),
                            
                            Text(
                              "Car color",
                              style: GoogleFonts.inter(
                                fontSize: 17,
                                color: Colors.grey,
                              ),
                            ),
                            AppInput(
                              controller: profile.carColor,
                            ),
                            Text(
                              "Plate Number",
                              style: GoogleFonts.inter(
                                fontSize: 17,
                                color: Colors.grey,
                              ),
                            ),
                            AppInput(
                              controller: profile.plateNumber,
                            ),
                            Text(
                              "Car Preference",
                              style: GoogleFonts.inter(
                                fontSize: 17,
                                color: Colors.grey,
                              ),
                            ),
                          
                            CarPreferenceInput(
                              controller: profile.carPreferences,
                              onValueChanged: (val) {
                              },
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Obx(
                                () => PrimaryButton(
                                  label: 'Update',
                                  isLoading: profile.loading.value,
                                  onPressed: () => profile.updateCar(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
              ]),
        ),
      ),
    );
  }
}

final List<String> carPreferences = [
  'Pet friendly',
  'No pet',
  '4 person',
  '6 person',
  'No smoking',
  'Air conditioning',
  'Baby seat',
  'No eating',
  'WiFi',
  'Music',
  'Dashcam',
  'Snacks',
];

class CarPreferenceInput extends StatefulWidget {
  final TextEditingController? controller;
  final String placeholder;
  final ValueChanged<String> onValueChanged;

  const CarPreferenceInput({
    Key? key,
    this.controller,
    this.placeholder = 'Car Preference ',
    required this.onValueChanged,
  }) : super(key: key);

  @override
  _CarPreferenceInputState createState() => _CarPreferenceInputState();
}

class _CarPreferenceInputState extends State<CarPreferenceInput> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showCarPreferenceOptions(context);
      },
      child: Container(
        height: 56,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                widget.controller?.text.isNotEmpty ?? false
                    ? widget.controller!.text.substring(2)
                    : '',
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
            ),
            const Icon(Icons.keyboard_arrow_down_rounded),
          ],
        ),
      ),
    );
  }

  void _showCarPreferenceOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return _buildPreferenceOptions(context);
      },
    ).then((result) {
      if (result != null && result is String) {
        widget.controller?.text = result;
        widget.onValueChanged(result);
      }
    });
  }

  Widget _buildPreferenceOptions(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return SizedBox(
          height: 400,
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, i) {
                    var item = carPreferences[i];
                    return ListTile(
                      onTap: () {
                        setState(() {
                          _updateSelectedPreferences(item);
                        });
                      },
                      title: Text(
                        item,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: widget.controller?.text
                                      .split(', ')
                                      .contains(item) ??
                                  false
                              ? AppColors.PRIMARY_COLOR
                              : Colors.black,
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: carPreferences.length,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(
                    context,
                    widget.controller?.text ?? "",
                  );
                },
                child: const Text("Save"),
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        );
      },
    );
  }

  void _updateSelectedPreferences(String preference) {
    if (widget.controller == null) {
      return;
    }

    setState(() {
      List<String> selectedPreferences =
          widget.controller!.text.split(', ').toList();

      if (selectedPreferences.contains(preference)) {
        selectedPreferences.remove(preference);
      } else {
        selectedPreferences.add(preference);
      }

      widget.controller!.text = selectedPreferences.join(", ");
    });
  }
}
