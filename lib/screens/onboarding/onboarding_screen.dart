import 'package:flutter/material.dart';
import 'package:quiz_test_task1/constants/app_routes.dart';
import 'package:quiz_test_task1/constants/assets.dart';
import 'package:quiz_test_task1/constants/colors.dart';
import 'package:quiz_test_task1/constants/sizes.dart';
import 'package:quiz_test_task1/screens/onboarding/widgets/bottom_button.dart';
import 'package:quiz_test_task1/screens/onboarding/widgets/content.dart';
import 'package:quiz_test_task1/screens/onboarding/widgets/indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentStep = 0;
  bool isSkipEnabled = false;
  final List<String> answers = ["", "", ""];

  @override
  void initState() {
    super.initState();
    _checkIfOnboardingCompleted();
  }

  Future<void> _checkIfOnboardingCompleted() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? completed = prefs.getBool('onboardingCompleted');
    if (completed == true) {
      isSkipEnabled = true;
      navigateToHomeScreen();
    } else {
      setState(() {
        isSkipEnabled = false;
      });
    }
  }

  Future<void> saveAnswer(int step, String answer) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    answers[step] = answer;
    if (step == 2) {
      await prefs.setBool('onboardingCompleted', true);
      await prefs.setStringList('onboardingAnswers', answers);
      navigateToHomeScreen();
    }
  }

  void navigateToHomeScreen() {
    Navigator.pushNamed(context, AppRoutesName.quizScreen);
  }

  void nextStep(String answer) {
    saveAnswer(currentStep, answer);
    if (currentStep < 2) {
      setState(() {
        currentStep++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: AppSizes.pandingForContent,
              vertical: AppSizes.space2pxH * 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (currentStep == 0) ...[
                questionStep(
                  question: "Which Exam Are You Studying For?",
                  options: ["NCLEX-PN", "NCLEX-RN", "Other"],
                  icons: [
                    AppAssets.iconsYoga,
                    AppAssets.iconsRunning,
                    AppAssets.other,
                  ],
                  onOptionSelected: (String answer) {
                    setState(() {
                      answers[currentStep] = answer;
                    });
                  },
                  selectedAnswer: answers[currentStep],
                ),
              ] else if (currentStep == 1) ...[
                questionStep(
                  question: "Choose Your Current Level",
                  options: ["Beginner", "Intermediate", "Advanced"],
                  icons: [
                    AppAssets.iconsYoga,
                    AppAssets.iconsYoga,
                    AppAssets.other,
                  ],
                  onOptionSelected: (String answer) {
                    setState(() {
                      answers[currentStep] = answer;
                    });
                  },
                  selectedAnswer: answers[currentStep],
                ),
              ] else if (currentStep == 2) ...[
                questionStep(
                  question: "Choose Your Target Level",
                  options: ["Pass", "Advanced", "Master"],
                  icons: [
                    AppAssets.iconsYoga,
                    AppAssets.iconsYoga,
                    AppAssets.iconsYoga,
                  ],
                  onOptionSelected: (String answer) {
                    setState(() {
                      answers[currentStep] = answer;
                    });
                  },
                  selectedAnswer: answers[currentStep],
                ),
              ],
              stepIndicator(currentStep: currentStep),
              BottomButton(
                isSkipEnabled: isSkipEnabled,
                onSkip: navigateToHomeScreen,
                isNextEnabled: answers[currentStep].isNotEmpty,
                onNext: () => nextStep(answers[currentStep]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
