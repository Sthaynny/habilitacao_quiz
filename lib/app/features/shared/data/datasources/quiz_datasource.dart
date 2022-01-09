import 'package:flutter/services.dart';

class QuizDatasource {
  Future<String> getQuiz(String nome) async {
    final String path = 'assets/json/${nome.trim()}.json';
    try {
      final response = await rootBundle.loadString(path);
      return response;
    } catch (e) {
      return '';
    }
  }
}
