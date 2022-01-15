import 'package:dartz/dartz.dart';
import 'package:quiz_car/app/features/shared/domain/entities/quiz_entity.dart';
import 'package:quiz_car/core/exceptions/erro.dart';

abstract class IQuizRepository {
  Future<Either<ExceptionErro, QuizEntity>> getQuiz(String nome);
  Future<Either<ExceptionErro, QuizEntity>> getSimulado();
}
