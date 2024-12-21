import 'dart:convert';
import 'package:dio/dio.dart';

class OpenAIService {
  final Dio dio;
  final String apiKey;

  OpenAIService(this.apiKey)
      : dio = Dio(
          BaseOptions(
            baseUrl: 'https://api.openai.com/v1/chat',
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $apiKey',
            },
          ),
        );

  Future<List<Map<String, dynamic>>> generateQuiz({
    required String category,
    required String currentLevel,
    required String targetLevel,
  }) async {
    final prompt = '''
    Generate 10 multiple-choice questions on $category for nursing students preparing for the NCLEX-RN exam.
    The questions should be suitable for a student at the current level: $currentLevel, aiming to reach the level: $targetLevel.
    Each question should have one correct answer and three incorrect options in the following JSON format:
    [
      {
        "question": "Question text",
        "options": ["Option1", "Option2", "Option3", "Option4"],
        "correct_answer": "Option2"
      },
      ...
    ]
  ''';

    try {
      final response = await dio.post(
        '/completions',
        data: jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": [
            {
              "role": "user",
              "content": prompt,
            }
          ],
          "max_tokens": 1000,
          "temperature": 0.7,
        }),
      );

      final data = response.data;
      final content = data['choices'][0]['message']['content'];
      return List<Map<String, dynamic>>.from(jsonDecode(content));
    } catch (e) {
      throw Exception('Failed to generate quiz: ${e.toString()}');
    }
  }
}
