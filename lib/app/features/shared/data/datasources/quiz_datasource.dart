import 'dart:io';

class QuizDatasource {
  Future<String> getQuiz(String nome) async {
    final String path = 'assets/arquivos/${nome.trim()}.json';
    try {
      return await File(path).readAsString();
    } catch (e) {
      return '';
    }

    // final quizzes =
    //     list.map((e) => QuizModel.fromMap(e as Map<String, dynamic>)).toList();
    // return quizzes;
  }
}
