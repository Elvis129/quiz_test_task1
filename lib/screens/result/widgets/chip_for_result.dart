import 'package:flutter/material.dart';
import 'package:quiz_test_task1/constants/colors.dart';
import 'package:quiz_test_task1/constants/sizes.dart';

class ChipForResult extends StatelessWidget {
  final String icon;
  final int value;
  final String title;
  const ChipForResult(
      {super.key,
      required this.icon,
      required this.value,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSizes.space2pxH * 42,
      width: AppSizes.space2pxW * 83,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.borderForChip)),
      child: Padding(
        padding: EdgeInsets.only(
          top: AppSizes.space2pxH * 8,
          left: AppSizes.space2pxW * 8,
          bottom: AppSizes.space2pxH * 8,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(icon),
            SizedBox(width: AppSizes.space2pxW * 6),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$value',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w700),
                ),
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.grayLight),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
