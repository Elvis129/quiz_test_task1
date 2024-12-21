import 'package:flutter/material.dart';
import 'package:quiz_test_task1/constants/app_routes.dart';
import 'package:quiz_test_task1/screens/quiz/cubit/quiz_cubit.dart';
import 'package:quiz_test_task1/screens/quiz/quiz_screen.dart';
import 'package:quiz_test_task1/screens/onboarding/onboarding_screen.dart';
import 'package:quiz_test_task1/screens/result/result_screen.dart';

class AppSettings {
  static final Map<String, WidgetBuilder> appRoutes = {
    AppRoutesName.onboardingScreen: (context) => const OnboardingScreen(),
    AppRoutesName.quizScreen: (context) => const QuizScreen(),
    AppRoutesName.resultScreen: (context) => ResultScreen(
          cubit: ModalRoute.of(context)?.settings.arguments as QuizCubit,
        ),
  };
}
