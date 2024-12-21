part of 'quiz_cubit.dart';

@freezed
class QuizState with _$QuizState {
  const factory QuizState.initial({
    MyResalt? myResalt,
    @Default(false) bool isOnboardingAnswers,
    @Default([]) List<Map<String, dynamic>> quizQuestions,
    @Default(false) bool isShowAnswers,
  }) = InitialQuizState;

  const factory QuizState.loading({
    MyResalt? myResalt,
    @Default(false) bool isOnboardingAnswers,
    @Default([]) List<Map<String, dynamic>> quizQuestions,
    @Default(false) bool isShowAnswers,
  }) = LoadingQuizState;

  const factory QuizState.error({
    MyResalt? myResalt,
    @Default(false) bool isOnboardingAnswers,
    @Default([]) List<Map<String, dynamic>> quizQuestions,
    @Default(false) bool isShowAnswers,
    @Default('') String error,
  }) = ErrorQuizState;
}
