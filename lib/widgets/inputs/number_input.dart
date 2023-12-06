import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app_input.dart';

class CarInput extends StatelessWidget {
  final TextEditingController? controller;
  final String placeholder;
  final ValueChanged<String> onValueChanged;

  const CarInput({
    Key? key,
    this.controller,
    this.placeholder = '',
    required this.onValueChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showNumberOptions(context);
      },
      child: AppInput(
        placeholder: placeholder.tr,
        suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded),
        enabled: false,
        controller: controller,
      ),
    );
  }

  void _showNumberOptions(BuildContext context) async {
    String? res = await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return const NumberOptions();
      },
    );
    if (res != null) {
      onValueChanged(res);
    }
  }
}

final List<String> options = [
  'Mini compact',
  'Compact',
  'Mini',
  'Van',
  'SUV',
  'Van'
];

class NumberOptions extends StatelessWidget {
  const NumberOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, i) {
                  var item = options[i];
                  return Column(children: [
                    ListTile(
                      onTap: () {
                        Get.back(result: item);
                      },
                      title: Text(
                        item,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                      ),
                    ),
                    const AppDivider()
                  ]);
                },
                itemCount: options.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppDivider extends StatelessWidget {
  final double? height;

  const AppDivider({Key? key, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: height,
      color: Get.isDarkMode ? Colors.white54 : Colors.grey.shade400,
    );
  }
}

class CarMake extends StatelessWidget {
  final TextEditingController? controller;
  final String placeholder;
  final ValueChanged<String> onValueChanged;

  const CarMake({
    Key? key,
    this.controller,
    this.placeholder = '',
    required this.onValueChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showNumberOptions(context);
      },
      child: AppInput(
        placeholder: placeholder.tr,
        suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded),
        enabled: false,
        controller: controller,
      ),
    );
  }

  void _showNumberOptions(BuildContext context) async {
    String? res = await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return const NumberOptions();
      },
    );
    if (res != null) {
      onValueChanged(res);
    }
  }
}

