import 'package:dartz/dartz.dart';
import 'package:quiz_car/app/features/shared/data/datasources/quiz_datasource.dart';
import 'package:quiz_car/app/features/shared/domain/entities/quiz_entity.dart';
import 'package:quiz_car/app/features/shared/domain/repositories/iquiz_repository.dart';
import 'package:quiz_car/core/exceptions/erro.dart';

class QuizRepository implements IQuizRepository {
  final QuizDatasource _datasource;

  QuizRepository(this._datasource);
  @override
  Future<Either<ExceptionErro, QuizEntity>> getQuiz(String nome) {
    // TODO: implement getQuiz
    throw UnimplementedError();
  }
}
