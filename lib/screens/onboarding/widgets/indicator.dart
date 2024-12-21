import 'package:flutter/material.dart';
import 'package:quiz_test_task1/constants/colors.dart';
import 'package:quiz_test_task1/constants/sizes.dart';

Widget stepIndicator({required int currentStep}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: List.generate(3, (index) {
      bool isActive = currentStep == index;
      return AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        width: isActive ? AppSizes.space2pxW * 18 : AppSizes.space2pxW * 3,
        height: AppSizes.space2pxH * 3,
        decoration: BoxDecoration(
          color: AppColors.black,
          borderRadius: BorderRadius.circular(8),
        ),
      );
    }),
  );
}
