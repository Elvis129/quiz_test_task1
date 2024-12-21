import 'package:flutter/material.dart';
import 'package:quiz_test_task1/constants/colors.dart';

class BottomButton extends StatelessWidget {
  final bool isSkipEnabled;
  final Function() onSkip;
  final bool isNextEnabled;
  final Function() onNext;

  const BottomButton({
    super.key,
    required this.isSkipEnabled,
    required this.onSkip,
    required this.isNextEnabled,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: isSkipEnabled ? onSkip : null,
          child: const Text(
            'Skip',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppColors.gray,
            ),
          ),
        ),
        GestureDetector(
          onTap: isNextEnabled ? onNext : null,
          child: const Row(
            children: [
              Text(
                'Next',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                ),
              ),
              SizedBox(width: 2),
              Icon(
                Icons.arrow_forward_ios,
                size: 18,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
