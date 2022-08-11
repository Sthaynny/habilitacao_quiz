import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habilitacao_quiz/app/shared/data/datasources/quiz_datasource.dart';
import 'package:habilitacao_quiz/app/shared/data/repositories/quiz_repository.dart';
import 'package:habilitacao_quiz/app/shared/domain/entities/quiz_entity.dart';
import 'package:habilitacao_quiz/app/shared/domain/repositories/iquiz_repository.dart';
import 'package:habilitacao_quiz/core/exceptions/erro.dart';
import 'package:habilitacao_quiz/core/utils/keys.dart';
import 'package:mockito/mockito.dart';

import '../../../features/home/domain/usecases/utils.dart';

class _MockSucessDatasource extends Mock implements QuizDatasource {
  @override
  Future<String> getQuiz(String nome) async {
    return tInstanceQuizModel.toJson();
  }
}

class _MockErrorDatasource extends Mock implements QuizDatasource {
  @override
  Future<String> getQuiz(String nome) async {
    return '';
  }
}

void main() {
  late IQuizRepository repositorySuccess;
  late IQuizRepository repositoryError;

  group('Teste Quiz repository', () {
    setUpAll(() {
      repositorySuccess = QuizRepository(_MockSucessDatasource());
      repositoryError = QuizRepository(_MockErrorDatasource());
    });
    group('getQuiz', () {
      test('Deve dar sucesso', () async {
        final result = await repositorySuccess.getQuiz(Keys.direcaoDefensiva);
        expect(result.isRight(), true);
        expect(result.fold(id, id), isA<QuizEntity>());
      });
      test('Deve dar erro', () async {
        final result = await repositoryError.getQuiz('alsjdha');
        expect(result.isLeft(), true);
        expect(result.fold(id, id), isA<ExceptionErro>());
      });
    });
    group('GetSimulado', () {
      test('Deve dar sucesso', () async {
        final result = await repositorySuccess.getSimulado();
        expect(result.isRight(), true);
        expect(result.fold(id, id), isA<QuizEntity>());
      });
      test('Deve dar erro', () async {
        final result = await repositoryError.getSimulado();
        expect(result.isLeft(), true);
        expect(result.fold(id, id), isA<ExceptionErro>());
      });
    });
  });
}
