import 'package:flutter/material.dart';
import 'package:flutter_application_17/constants/app_colors.dart';

class GradientContainer extends StatelessWidget {
  final Widget child;
  const GradientContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.001, 0.51, 0.87, 1.0],
          colors: [
            AppColors.gradient1,
            AppColors.gradient2,
            AppColors.gradient3,
            AppColors.gradient4,
          ],
        ),
      ),
      child: child,
    );
  }
}
