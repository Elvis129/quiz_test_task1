// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quiz_test_task1/constants/app_routes.dart';
import 'package:quiz_test_task1/models/my_resalt.dart';
import 'package:quiz_test_task1/services/openai_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'quiz_state.dart';
part 'quiz_cubit.freezed.dart';

class QuizCubit extends Cubit<QuizState> {
  QuizCubit() : super(const InitialQuizState());

  int currentQuestionIndex = 0;
  int correctAnswersCount = 0;

  Future<void> start(BuildContext context) async {
    try {
      bool isOnboardingAnswers = false;
      List<Map<String, dynamic>> quizQuestions = [];
      OpenAIService openAIService;
      openAIService = OpenAIService(
          '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');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String>? onboardingAnswers =
          prefs.getStringList('onboardingAnswers');

      MyResalt? myResalt;
      if (prefs.containsKey('myResalt')) {
        myResalt = MyResalt.fromJson(prefs.getString('myResalt')!);
      } else {
        myResalt =
            MyResalt(many: 0, xp: 0, time: 0, correct: 0, timeAVG: 0, count: 0);
        await prefs.setString('myResalt', myResalt.toJson());
      }

      if (onboardingAnswers == null || onboardingAnswers.length < 3) {
        isOnboardingAnswers = false;
        Navigator.pushNamed(context, AppRoutesName.onboardingScreen);
      } else {
        quizQuestions = await openAIService.generateQuiz(
          category: onboardingAnswers[0],
          currentLevel: onboardingAnswers[1],
          targetLevel: onboardingAnswers[2],
        );
      }

      emit(InitialQuizState(
        myResalt: myResalt,
        isOnboardingAnswers: isOnboardingAnswers,
        quizQuestions: quizQuestions,
      ));
    } catch (e) {}
  }

  checkAnswers(dynamic options, dynamic correctAnswer) async {
    try {
      bool isShowAnswers = true;
      emit(state.copyWith(isShowAnswers: isShowAnswers));
      await Future.delayed(const Duration(seconds: 1));
      isShowAnswers = false;
      emit(state.copyWith(isShowAnswers: isShowAnswers));

      if (options == correctAnswer) {
        MyResalt updatedResult = state.myResalt!.copyWith(
          correct: state.myResalt!.correct + 1,
          xp: state.myResalt!.xp + 100,
          many: state.myResalt!.many + 50,
        );

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('myResalt', updatedResult.toJson());

        emit(state.copyWith(myResalt: updatedResult));
      }
    } catch (e) {}
  }

  updateTime(int time) async {
    try {
      MyResalt updatedResult = state.myResalt!.copyWith(
        time: state.myResalt!.time + time,
        count: state.myResalt!.count + 1,
        timeAVG: (state.myResalt!.time + time) ~/ (state.myResalt!.count + 1),
        correct: state.myResalt!.correct,
        xp: state.myResalt!.xp,
        many: state.myResalt!.many,
      );
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('myResalt', updatedResult.toJson());

      emit(state.copyWith(myResalt: updatedResult));
    } catch (e) {}
  }
}
