import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_test_task1/constants/app_routes.dart';
import 'package:quiz_test_task1/constants/assets.dart';
import 'package:quiz_test_task1/constants/colors.dart';
import 'package:quiz_test_task1/constants/sizes.dart';
import 'package:quiz_test_task1/screens/quiz/cubit/quiz_cubit.dart';
import 'package:quiz_test_task1/screens/quiz/cubit/widgets/progress_indicator_for_quiz.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestionIndex = 0;
  int totalTime = 0;
  late Timer _timer;
  String selectedOption = '';
  String feedbackMessage = '';
  Color feedbackColor = Colors.transparent;
  String feedbackTitle = '';
  bool isFeedbackVisible = false;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        totalTime++;
      });
    });
  }

  void nextQuestion(QuizCubit cubit) {
    if (currentQuestionIndex < 9) {
      setState(() {
        currentQuestionIndex++;
        selectedOption = "";
        isFeedbackVisible = false;
      });
      _pageController.nextPage(
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeInOut,
      );
    } else {
      cubit.updateTime(totalTime);
      _timer.cancel();
      Navigator.pushNamed(
        context,
        AppRoutesName.resultScreen,
        arguments: cubit,
      );
    }
  }

  void showFeedback(
      String title, String message, Color color, QuizCubit cubit) {
    setState(() {
      feedbackTitle = title;
      feedbackMessage = message;
      feedbackColor = color;
      isFeedbackVisible = true;
    });
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        isFeedbackVisible = false;
      });
      nextQuestion(cubit);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<QuizCubit>(
      create: (context) => QuizCubit()..start(context),
      child: BlocConsumer<QuizCubit, QuizState>(
        listener: (context, state) {
          if (state is ErrorQuizState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.error}')),
            );
          }
          if (state is InitialQuizState && totalTime == 0) {
            startTimer();
          }
        },
        builder: (context, state) {
          final quizCubit = context.read<QuizCubit>();

          if (state is InitialQuizState &&
              quizCubit.state.quizQuestions.isNotEmpty) {
            final question =
                quizCubit.state.quizQuestions[currentQuestionIndex];
            final options = question['options'];
            final correctAnswer = question['correct_answer'];

            return Scaffold(
              backgroundColor: AppColors.white,
              body: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: AppSizes.pandingForContent),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: AppSizes.space2pxH * 30),
                        Stack(
                          children: [
                            SizedBox(
                              height: AppSizes.space2pxH * 29,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${currentQuestionIndex + 1}/${quizCubit.state.quizQuestions.length}',
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  InkWell(
                                    onTap: () {},
                                    child: const Icon(
                                      Icons.close,
                                      size: 25,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Center(
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Text(
                                    '$totalTime',
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  ProgressIndicatorForQuiz(
                                    progress: (currentQuestionIndex + 1) /
                                        quizCubit.state.quizQuestions.length,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: AppSizes.space2pxH * 15),
                        Image.asset(AppAssets.iconForQuiz),
                        Expanded(
                          child: PageView.builder(
                            controller: _pageController,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: quizCubit.state.quizQuestions.length,
                            itemBuilder: (context, index) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: AppSizes.space2pxH * 8),
                                    child: Text(
                                      question['question'],
                                      style: const TextStyle(
                                          fontSize: 28,
                                          fontWeight: FontWeight.w700),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  SizedBox(height: AppSizes.space2pxH * 5),
                                  Container(
                                    height: 1,
                                    color: AppColors.border,
                                  ),
                                  SizedBox(height: AppSizes.space2pxH * 5),
                                  Expanded(
                                    child: ListView.builder(
                                      padding: EdgeInsets.only(
                                          top: AppSizes.space2pxH * 10),
                                      itemCount: options.length,
                                      itemBuilder: (context, index) {
                                        final option = options[index];
                                        option == selectedOption;

                                        return GestureDetector(
                                          onTap: () async {
                                            setState(() {
                                              selectedOption = option;
                                            });
                                            quizCubit.checkAnswers(
                                                option, correctAnswer);

                                            if (option == correctAnswer) {
                                              showFeedback('Correct!', '+945',
                                                  AppColors.green, quizCubit);
                                            } else {
                                              showFeedback(
                                                  'Incorrect!',
                                                  'That was close',
                                                  AppColors.red,
                                                  quizCubit);
                                            }
                                          },
                                          child: Container(
                                            margin: EdgeInsets.symmetric(
                                              vertical: AppSizes.space2pxH * 5,
                                            ),
                                            padding: EdgeInsets.symmetric(
                                                vertical:
                                                    AppSizes.space2pxH * 6),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              color:
                                                  quizCubit.state.isShowAnswers
                                                      ? option == correctAnswer
                                                          ? AppColors.green
                                                          : AppColors.red
                                                      : AppColors.blue,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: quizCubit
                                                          .state.isShowAnswers
                                                      ? option == correctAnswer
                                                          ? AppColors
                                                              .shadowGreen
                                                          : AppColors.shadowRed
                                                      : AppColors.shadowBlue,
                                                  offset: const Offset(0, 5),
                                                ),
                                              ],
                                            ),
                                            child: Text(
                                              option,
                                              style: const TextStyle(
                                                  color: AppColors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 100),
                    top: isFeedbackVisible ? 0 : -AppSizes.height! * 0.2,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: AppSizes.height! * 0.2,
                      color: feedbackColor,
                      // alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            feedbackTitle,
                            style: const TextStyle(
                              color: AppColors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: AppSizes.space2pxH * 8),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: AppSizes.space2pxH * 5,
                                horizontal: AppSizes.pandingForContent),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: AppColors.white),
                            child: Text(
                              feedbackMessage,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: feedbackColor),
                            ),
                          ),
                          SizedBox(height: AppSizes.pandingForContent)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          return Container(
            color: AppColors.white,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}
