import 'package:dartz/dartz.dart';
import 'package:habilitacao_quiz/app/shared/domain/entities/quiz_entity.dart';
import 'package:habilitacao_quiz/core/exceptions/erro.dart';

abstract class IQuizRepository {
  Future<Either<ExceptionErro, QuizEntity>> getQuiz(String nome);
  Future<Either<ExceptionErro, QuizEntity>> getSimulado();
}
