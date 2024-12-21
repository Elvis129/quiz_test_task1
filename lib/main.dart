import 'package:flutter/material.dart';
import 'package:quiz_test_task1/constants/app_routes.dart';
import 'package:quiz_test_task1/constants/settings.dart';
import 'package:quiz_test_task1/constants/sizes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    AppSizes.width = MediaQuery.sizeOf(context).width;
    AppSizes.height = MediaQuery.sizeOf(context).height;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutesName.quizScreen,
      routes: AppSettings.appRoutes,
    );
  }
}
