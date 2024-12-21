// import 'package:flutter/material.dart';
// import 'package:quiz_test_task1/constants/colors.dart';
// import 'package:quiz_test_task1/constants/sizes.dart';

// // ignore: must_be_immutable
// class Content extends StatefulWidget {
//   String feedbackTitle;
//   String feedbackMessage;
//   Color feedbackColor;
//   bool isFeedbackVisible;
//   Content(
//       {super.key,
//       required this.feedbackTitle,
//       required this.feedbackMessage,
//       required this.feedbackColor,
//       required this.isFeedbackVisible});

//   @override
//   State<Content> createState() => _ContentState();
// }

// class _ContentState extends State<Content> {
//   void showFeedback(String title, String message, Color color) {
//     setState(() {
      
//       widget.feedbackTitle = title;
//       widget.feedbackMessage = message;
//       widget.feedbackColor = color;
//       widget.isFeedbackVisible = true;
//     });
//     Future.delayed(const Duration(seconds: 1), () {
//       setState(() {
//         widget.isFeedbackVisible = false;
//       });
//       nextQuestion();
//     });
//   }

//     void nextQuestion() {
//     if (currentQuestionIndex < 9) {
//       setState(() {
//         currentQuestionIndex++;
//         selectedOption = "";
//         isFeedbackVisible = false;
//       });
//       _pageController.nextPage(
//         duration: const Duration(milliseconds: 100),
//         curve: Curves.easeInOut,
//       );
//     } else {
//       _timer.cancel();
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Quiz Finished!")),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: PageView.builder(
//         controller: _pageController,
//         physics: const NeverScrollableScrollPhysics(),
//         itemCount: quizCubit.state.quizQuestions.length,
//         itemBuilder: (context, index) {
//           return Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: EdgeInsets.symmetric(vertical: AppSizes.space2pxH * 8),
//                 child: Text(
//                   question['question'],
//                   style: const TextStyle(
//                       fontSize: 28, fontWeight: FontWeight.w700),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//               SizedBox(height: AppSizes.space2pxH * 5),
//               Container(
//                 height: 1,
//                 color: AppColors.border,
//               ),
//               SizedBox(height: AppSizes.space2pxH * 5),
//               Expanded(
//                 child: ListView.builder(
//                   padding: EdgeInsets.only(top: AppSizes.space2pxH * 10),
//                   itemCount: options.length,
//                   itemBuilder: (context, index) {
//                     final option = options[index];
//                     option == selectedOption;

//                     return GestureDetector(
//                       onTap: () async {
//                         setState(() {
//                           selectedOption = option;
//                         });
//                         quizCubit.checkAnswers(options, correctAnswer);

//                         if (option == correctAnswer) {
//                           showFeedback('Correct!', '+945', AppColors.green);
//                         } else {
//                           showFeedback(
//                               'Incorrect!', 'That was close', AppColors.red);
//                         }
//                       },
//                       child: Container(
//                         margin: EdgeInsets.symmetric(
//                           vertical: AppSizes.space2pxH * 5,
//                         ),
//                         padding: EdgeInsets.symmetric(
//                             vertical: AppSizes.space2pxH * 6),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(100),
//                           color: quizCubit.state.isShowAnswers
//                               ? option == correctAnswer
//                                   ? AppColors.green
//                                   : AppColors.red
//                               : AppColors.blue,
//                           boxShadow: [
//                             BoxShadow(
//                               color: quizCubit.state.isShowAnswers
//                                   ? option == correctAnswer
//                                       ? AppColors.shadowGreen
//                                       : AppColors.shadowRed
//                                   : AppColors.shadowBlue,
//                               offset: const Offset(0, 5),
//                             ),
//                           ],
//                         ),
//                         child: Text(
//                           option,
//                           style: const TextStyle(
//                               color: AppColors.white,
//                               fontSize: 18,
//                               fontWeight: FontWeight.w700),
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
