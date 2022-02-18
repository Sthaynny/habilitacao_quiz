import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:quiz_car/app/shared/data/datasources/quiz_datasource.dart';
import 'package:quiz_car/app/shared/data/models/questoes_model.dart';
import 'package:quiz_car/app/shared/data/repositories/quiz_repository.dart';
import 'package:quiz_car/app/shared/domain/entities/quiz_entity.dart';
import 'package:quiz_car/app/shared/domain/repositories/iquiz_repository.dart';
import 'package:quiz_car/core/exceptions/erro.dart';
import 'package:quiz_car/core/utils/keys.dart';

import '../../../utils/utils.dart';

class _MockDatasource extends Mock implements QuizDatasource {}

void main() {
  late _MockDatasource datasource;
  late IQuizRepository repository;

  group('Teste Quiz repository', () {
    setUp(() {
      datasource = _MockDatasource();
      repository = QuizRepository(datasource);
    });
    final tInstanceQuizModel = QuizModel.fromMap(tMapQuizModel);
    group('getQuiz', () {
      test('Deve dar sucesso', () async {
        when(() => datasource.getQuiz(any())).thenAnswer(
          (_) async => tInstanceQuizModel.toJson(),
        );
        final result = await repository.getQuiz(Keys.direcaoDefensiva);
        expect(result.isRight(), true);
        expect(result.fold(id, id), isA<QuizEntity>());
      });
      test('Deve dar erro', () async {
        when(() => datasource.getQuiz(any())).thenAnswer(
          (_) async => '',
        );
        final result = await repository.getQuiz('alsjdha');
        expect(result.isLeft(), true);
        expect(result.fold(id, id), isA<ExceptionErro>());
      });
    });
    group('GetSimulado', () {
      test('Deve dar sucesso', () async {
        when(() => datasource.getQuiz(any())).thenAnswer(
          (_) async => tInstanceQuizModel.toJson(),
        );

        final result = await repository.getSimulado();
        expect(result.isRight(), true);
        expect(result.fold(id, id), isA<QuizEntity>());
      });
      test('Deve dar erro', () async {
        when(() => datasource.getQuiz(any())).thenAnswer(
          (_) async => '',
        );
        final result = await repository.getSimulado();
        expect(result.isLeft(), true);
        expect(result.fold(id, id), isA<ExceptionErro>());
      });
    });
  });
}
