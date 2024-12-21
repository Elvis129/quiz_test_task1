import 'package:flutter/material.dart';
import 'package:quiz_test_task1/constants/assets.dart';
import 'package:quiz_test_task1/constants/colors.dart';
import 'package:quiz_test_task1/constants/sizes.dart';
import 'package:quiz_test_task1/screens/quiz/cubit/quiz_cubit.dart';
import 'package:quiz_test_task1/screens/result/widgets/button_for_result.dart';
import 'package:quiz_test_task1/screens/result/widgets/chip_for_result.dart';

class ResultScreen extends StatelessWidget {
  final QuizCubit cubit;
  const ResultScreen({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: EdgeInsets.only(
          top: AppSizes.space2pxH * 30,
          left: AppSizes.pandingForContent,
          right: AppSizes.pandingForContent,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {},
                  child: const Icon(
                    Icons.close,
                    color: AppColors.blueIndicator,
                  ),
                ),
                const Text(
                  'Result',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: AppColors.blueIndicator),
                ),
                SizedBox(
                  width: AppSizes.space2pxW * 5,
                )
              ],
            ),
            SizedBox(height: AppSizes.space2pxH * 20),
            Image.asset(AppAssets.iconWin),
            SizedBox(height: AppSizes.space2pxH * 5),
            const Text(
              'Your Achievements',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: AppSizes.space2pxH * 10),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ChipForResult(
                      icon: AppAssets.iconCoin,
                      value: cubit.state.myResalt?.many ?? 0,
                      title: 'Coins Earned',
                    ),
                    ChipForResult(
                      icon: AppAssets.iconChallenge,
                      value: cubit.state.myResalt?.xp ?? 0,
                      title: 'XP',
                    ),
                  ],
                ),
                SizedBox(height: AppSizes.space2pxH * 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ChipForResult(
                      icon: AppAssets.iconClock,
                      value: cubit.state.myResalt?.timeAVG ?? 0,
                      title: 'AVG time',
                    ),
                    ChipForResult(
                      icon: AppAssets.iconBadgeRank,
                      value: cubit.state.myResalt?.correct ?? 0,
                      title: 'Correct Questions',
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: AppSizes.space2pxH * 5),
            const ButtonForResult()
          ],
        ),
      ),
    );
  }
}
