import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quiz_car/app/features/shared/data/datasources/quiz_datasource.dart';
import 'package:quiz_car/app/features/shared/data/repositories/quiz_repository.dart';
import 'package:quiz_car/app/features/shared/domain/entities/quiz_entity.dart';
import 'package:quiz_car/app/features/shared/domain/repositories/iquiz_repository.dart';
import 'package:quiz_car/core/exceptions/erro.dart';

void main() {
  final QuizDatasource datasource = QuizDatasource();
  IQuizRepository repository = QuizRepository(datasource);

  group('Teste Quiz repository', () {
    test('Deve dar sucesso', () async {
      final result = await repository.getQuiz('direcao_defensiva');
      expect(result.isRight(), true);
      expect(result.fold(id, id), isA<QuizEntity>());
    });
    test('Deve dar erro', () async {
      final result = await repository.getQuiz('alsjdha');
      expect(result.isLeft(), true);
      expect(result.fold(id, id), isA<ExceptionErro>());
    });
  });
}
