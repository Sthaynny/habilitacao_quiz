import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habilitacao_quiz/app/features/home/domain/usecases/mecanica_basica_quiz_usercase.dart';
import 'package:habilitacao_quiz/app/shared/domain/entities/quiz_entity.dart';
import 'package:habilitacao_quiz/core/exceptions/erro.dart';

import 'utils.dart';

void main() {
  late final MockSuccessQuizRepository repositorySucess;
  late final MockErrorQuizRepository repositoryError;
  late final MecanicaBasicaQuizUsercase usercaseSucess;
  late final MecanicaBasicaQuizUsercase usercaseError;
  setUpAll(() {
    repositorySucess = MockSuccessQuizRepository();
    repositoryError = MockErrorQuizRepository();
    usercaseSucess = MecanicaBasicaQuizUsercase(repositorySucess);
    usercaseError = MecanicaBasicaQuizUsercase(repositoryError);
  });
  group('Teste MecanicaBasicaQuizUsercase', () {
    test('Deve dar sucesso', () async {
      final result = await usercaseSucess.call();
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
