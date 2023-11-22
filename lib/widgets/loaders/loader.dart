import 'package:flutter/material.dart';
import 'package:rockyconnectdriver/theme/colors.dart';

class LoaderIcon extends StatelessWidget {
  const LoaderIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(
        AppColors.PRIMARY_COLOR,
      ),
    );
  }
}
