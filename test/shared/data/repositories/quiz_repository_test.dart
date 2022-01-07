import 'package:flutter_test/flutter_test.dart';
import 'package:quiz_car/app/features/shared/data/datasources/quiz_datasource.dart';
import 'package:quiz_car/app/features/shared/data/repositories/quiz_repository.dart';
import 'package:quiz_car/app/features/shared/domain/repositories/iquiz_repository.dart';

void main(List<String> args) {
  final QuizDatasource datasource = QuizDatasource();
  IQuizRepository repository = QuizRepository(datasource);

  group('Teste Quiz repository', () {
    test('Deve dar sucesso', () async {
      final result = await repository.getQuiz('direcao_defensiva');
      expect(result.isRight(), true);
    });
    test('Deve dar erro', () async {
      final result = await repository.getQuiz('alsjdha');
      expect(result.isLeft(), true);
    });
  });
}
