import 'package:flutter/material.dart';
import 'package:quiz_test_task1/constants/assets.dart';
import 'package:quiz_test_task1/constants/colors.dart';
import 'package:quiz_test_task1/constants/sizes.dart';

Widget questionStep({
  required String question,
  required List<String> options,
  required List<String> icons,
  required void Function(String answer) onOptionSelected,
  required String selectedAnswer,
}) {
  return Column(
    children: [
      Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: AppSizes.height! * 0.5,
            decoration: BoxDecoration(
              color: AppColors.gray,
              borderRadius: BorderRadius.circular(AppSizes.pandingForContent),
            ),
          ),
          Image.asset(AppAssets.apple),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSizes.pandingForContent,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ...options.asMap().entries.map((entry) {
                  int index = entry.key;
                  String option = entry.value;

                  return Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: AppSizes.space2pxH * 5,
                    ),
                    child: GestureDetector(
                      onTap: () => onOptionSelected(option),
                      child: Container(
                        height: AppSizes.space2pxH * 25,
                        decoration: BoxDecoration(
                          color: selectedAnswer == option
                              ? AppColors.lightBlue
                              : AppColors.white,
                          borderRadius: BorderRadius.circular(
                            AppSizes.space2pxW * 3,
                          ),
                          border: selectedAnswer == option
                              ? Border.all(
                                  width: 2, color: AppColors.borderBlue)
                              : Border.all(
                                  width: 1, color: AppColors.borderGray),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: AppSizes.space2pxW * 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Image.asset(
                                      icons[index],
                                      width: AppSizes.space2pxW * 12,
                                    ),
                                    SizedBox(width: AppSizes.space2pxW * 7),
                                    Text(
                                      option,
                                      style: const TextStyle(
                                        color: AppColors.black,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: AppSizes.space2pxW * 9,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: AppColors.borderBlue,
                                    width: 1.5,
                                  ),
                                  color: selectedAnswer == option
                                      ? AppColors.borderBlue
                                      : AppColors.white,
                                ),
                                child: selectedAnswer == option
                                    ? const Icon(
                                        Icons.check,
                                        size: 16,
                                        color: AppColors.white,
                                      )
                                    : null,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
      SizedBox(height: AppSizes.space2pxH * 14),
      Text(
        question,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w700,
        ),
      )
    ],
  );
}
