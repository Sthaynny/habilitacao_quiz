import 'package:flutter_test/flutter_test.dart';
import 'package:quiz_car/app/features/shared/data/datasources/quiz_datasource.dart';

void main() {
  QuizDatasource datasource = QuizDatasource();
  group('test Quizdatasource', () {
    /// test_sucesso: verificar como mockar um serviço do flutter

    test("Deve dar erro", () async {
      final result = await datasource.getQuiz('a');
      expect(result.isNotEmpty, false);
    });
  });
}
