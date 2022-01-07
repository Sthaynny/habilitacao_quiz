import 'package:flutter_test/flutter_test.dart';
import 'package:quiz_car/app/features/shared/data/datasources/quiz_datasource.dart';

void main() {
  QuizDatasource datasource = QuizDatasource();
  group('test Quizdatasource', () {
    test("Deve retorna uma string", () async {
      final result = await datasource.getQuiz('direcao_defensiva');
      expect(result.isNotEmpty, true);
    });

    test("Deve dar erro", () async {
      final result = await datasource.getQuiz('a');
      expect(result.isNotEmpty, false);
    });
  });
}
