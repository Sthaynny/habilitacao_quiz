import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habilitacao_quiz/app/features/home/domain/usecases/direcao_defensiva_quiz_usercase.dart';
import 'package:habilitacao_quiz/app/shared/domain/entities/quiz_entity.dart';
import 'package:habilitacao_quiz/core/exceptions/erro.dart';

import 'utils.dart';

void main() {
  late final MockSuccessQuizRepository repositorySucess;
  late final MockErrorQuizRepository repositoryError;
  late final DirecaoDefesivaQuizUsercase usecaseSucess;
  late final DirecaoDefesivaQuizUsercase usercaseError;
  setUpAll(() {
    repositorySucess = MockSuccessQuizRepository();
    repositoryError = MockErrorQuizRepository();
    usecaseSucess = DirecaoDefesivaQuizUsercase(repositorySucess);
    usercaseError = DirecaoDefesivaQuizUsercase(repositoryError);
  });

  group('Teste DirecaoDefencivaQuizUsercase', () {
    test('Deve dar sucesso', () async {
      final result = await usecaseSucess.call();
      expect(result.isRight(), true);
      expect(result.fold(id, id), isA<QuizEntity>());
    });
    test('Deve dar erro', () async {
      final result = await usercaseError.call();
      expect(result.isLeft(), true);
      expect(result.fold(id, id), isA<ExceptionErro>());
    });
  });
}
