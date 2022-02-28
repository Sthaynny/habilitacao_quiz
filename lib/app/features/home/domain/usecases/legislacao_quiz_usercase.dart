import 'package:dartz/dartz.dart';
import 'package:habilitacao_quiz/app/shared/domain/entities/quiz_entity.dart';
import 'package:habilitacao_quiz/app/shared/domain/repositories/iquiz_repository.dart';
import 'package:habilitacao_quiz/core/exceptions/erro.dart';
import 'package:habilitacao_quiz/core/utils/keys.dart';

class LegislacaoQuizUsercase {
  LegislacaoQuizUsercase(this.repository);
  final IQuizRepository repository;
  Future<Either<ExceptionErro, QuizEntity>> call() {
    return repository.getQuiz(Keys.legislacao);
  }
}
