import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habilitacao_quiz/app/features/home/domain/usecases/simulado_quiz_usercase.dart';
import 'package:habilitacao_quiz/app/shared/data/models/questoes_model.dart';
import 'package:habilitacao_quiz/app/shared/data/repositories/quiz_repository.dart';
import 'package:habilitacao_quiz/app/shared/domain/entities/quiz_entity.dart';
import 'package:habilitacao_quiz/core/exceptions/erro.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../utils/utils.dart';

class _MockRepository extends Mock implements QuizRepository {}

void main() {
  final _MockRepository repository = _MockRepository();
  final SimuladoQuizUsercase usercase = SimuladoQuizUsercase(repository);

  group('Teste SimuladoQuizUsercase', () {
    final tInstanceQuizModel = QuizModel.fromMap(tMapQuizModel);
    test('Deve dar sucesso', () async {
      when(() => repository.getSimulado()).thenAnswer(
        (_) async => right(tInstanceQuizModel),
      );
      final result = await usercase.call();
      expect(result.isRight(), true);
      expect(result.fold(id, id), isA<QuizEntity>());
    });
    test('Deve dar erro', () async {
      when(() => repository.getSimulado()).thenAnswer(
        (realInvocation) async => left(ExceptionErro()),
      );
      final result = await usercase.call();
      expect(result.isLeft(), true);
      expect(result.fold(id, id), isA<ExceptionErro>());
    });
  });
}
