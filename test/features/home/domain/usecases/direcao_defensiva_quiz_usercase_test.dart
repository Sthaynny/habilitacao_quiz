import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:quiz_car/app/features/home/domain/usecases/mecanica_basica_quiz_usercase.dart';
import 'package:quiz_car/app/features/shared/data/models/questoes_model.dart';
import 'package:quiz_car/app/features/shared/data/repositories/quiz_repository.dart';
import 'package:quiz_car/app/features/shared/domain/entities/quiz_entity.dart';
import 'package:quiz_car/core/exceptions/erro.dart';

import '../../../../utils/utils.dart';

class _MockRepository extends Mock implements QuizRepository {}

void main() {
  final _MockRepository repository = _MockRepository();
  final MecanicaBasicaQuizUsercase usercase =
      MecanicaBasicaQuizUsercase(repository);

  group('Teste MecanicaBasicaQuizUsercase', () {
    final tInstanceQuizModel = QuizModel.fromMap(tMapQuizModel);
    test('Deve dar sucesso', () async {
      when(() => repository.getQuiz(any())).thenAnswer(
        (_) async => right(tInstanceQuizModel),
      );
      final result = await usercase.call();
      expect(result.isRight(), true);
      expect(result.fold(id, id), isA<QuizEntity>());
    });
    test('Deve dar erro', () async {
      when(() => repository.getQuiz(any())).thenAnswer(
        (realInvocation) async => left(ExceptionErro()),
      );
      final result = await usercase.call();
      expect(result.isLeft(), true);
      expect(result.fold(id, id), isA<ExceptionErro>());
    });
  });
}
