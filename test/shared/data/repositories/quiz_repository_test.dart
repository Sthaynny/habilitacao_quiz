import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habilitacao_quiz/app/shared/data/datasources/quiz_datasource.dart';
import 'package:habilitacao_quiz/app/shared/data/repositories/quiz_repository.dart';
import 'package:habilitacao_quiz/app/shared/domain/entities/quiz_entity.dart';
import 'package:habilitacao_quiz/app/shared/domain/repositories/iquiz_repository.dart';
import 'package:habilitacao_quiz/app/shared/domain/services/pro_gate.dart';
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
      final gate = StubProGate();
      repositorySuccess = QuizRepository(_MockSucessDatasource(), gate);
      repositoryError = QuizRepository(_MockErrorDatasource(), gate);
    });
    group('getQuiz', () {
      test('Deve dar sucesso', () async {
        final result = await repositorySuccess.getQuiz(Keys.direcaoDefensiva);
        expect(result.isRight(), true);
        expect(result.fold(id, id), isA<QuizEntity>());
      });
      test('Free limita sessão de tema a 15 perguntas', () async {
        final gate = StubProGate();
        final repo = QuizRepository(_MockSucessDatasource(), gate);
        final result = await repo.getQuiz(Keys.direcaoDefensiva);
        final quiz = result.getOrElse(() => QuizEntity.empty());
        expect(quiz.perguntas.length, lessThanOrEqualTo(15));
      });
      test('Pro usa banco completo no tema (sem cap de 15)', () async {
        final gate = StubProGate(isPro: true);
        final repo = QuizRepository(_MockSucessDatasource(), gate);
        final result = await repo.getQuiz(Keys.direcaoDefensiva);
        final quiz = result.getOrElse(() => QuizEntity.empty());
        expect(quiz.perguntas.length, greaterThan(15));
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
      test('Free monta simulado com 15 questões', () async {
        final gate = StubProGate();
        final repo = QuizRepository(_MockSucessDatasource(), gate);
        final result = await repo.getSimulado();
        final quiz = result.getOrElse(() => QuizEntity.empty());
        expect(quiz.perguntas.length, 15);
      });
      test('Pro monta simulado com 30 questões', () async {
        final gate = StubProGate(isPro: true);
        final repo = QuizRepository(_MockSucessDatasource(), gate);
        final result = await repo.getSimulado();
        final quiz = result.getOrElse(() => QuizEntity.empty());
        expect(quiz.perguntas.length, 30);
      });
      test('Deve dar erro', () async {
        final result = await repositoryError.getSimulado();
        expect(result.isLeft(), true);
        expect(result.fold(id, id), isA<ExceptionErro>());
      });
    });
  });
}
