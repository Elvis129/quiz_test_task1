import 'package:flutter/material.dart';
import 'package:quiz_test_task1/constants/app_routes.dart';
import 'package:quiz_test_task1/constants/assets.dart';
import 'package:quiz_test_task1/constants/colors.dart';
import 'package:quiz_test_task1/constants/sizes.dart';

class ButtonForResult extends StatelessWidget {
  const ButtonForResult({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: AppSizes.space2pxH * 10),
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, AppRoutesName.quizScreen);
            },
            child: Container(
              height: AppSizes.space2pxH * 32,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: AppColors.blue,
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.shadowBlue,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(AppAssets.iconDesign),
                  SizedBox(width: AppSizes.space2pxW * 7),
                  const Text(
                    'Retry',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: AppColors.white),
                  )
                ],
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {},
              child: Container(
                height: AppSizes.space2pxH * 29,
                width: AppSizes.space2pxW * 82,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: AppColors.blue,
                  boxShadow: const [
                    BoxShadow(
                      color: AppColors.shadowBlue,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(AppAssets.iconHome),
                    SizedBox(width: AppSizes.space2pxW * 7),
                    const Text(
                      'Home',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.white),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                height: AppSizes.space2pxH * 29,
                width: AppSizes.space2pxW * 82,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: AppColors.blue,
                  boxShadow: const [
                    BoxShadow(
                      color: AppColors.shadowBlue,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(AppAssets.iconSend),
                    SizedBox(width: AppSizes.space2pxW * 7),
                    const Text(
                      'Share',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.white),
                    )
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
