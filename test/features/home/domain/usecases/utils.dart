import 'package:dartz/dartz.dart';
import 'package:habilitacao_quiz/app/shared/data/models/questoes_model.dart';
import 'package:habilitacao_quiz/app/shared/domain/entities/quiz_entity.dart';
import 'package:habilitacao_quiz/app/shared/domain/repositories/iquiz_repository.dart';
import 'package:habilitacao_quiz/core/exceptions/erro.dart';
import 'package:mockito/mockito.dart';

import '../../../../utils/utils.dart';

final tInstanceQuizModel = QuizModel.fromMap(tMapQuizModel);

class MockSuccessQuizRepository extends Mock implements IQuizRepository {
  @override
  Future<Either<ExceptionErro, QuizEntity>> getQuiz(String nome) async {
    return right(tInstanceQuizModel);
  }

  @override
  Future<Either<ExceptionErro, QuizEntity>> getSimulado() async {
    return right(tInstanceQuizModel);
  }
}

class MockErrorQuizRepository extends Mock implements IQuizRepository {
  @override
  Future<Either<ExceptionErro, QuizEntity>> getQuiz(String nome) async {
    return left(ExceptionErro());
  }

  @override
  Future<Either<ExceptionErro, QuizEntity>> getSimulado() async {
    return left(ExceptionErro());
  }
}
