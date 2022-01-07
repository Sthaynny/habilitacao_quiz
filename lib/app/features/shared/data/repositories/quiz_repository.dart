import 'package:dartz/dartz.dart';
import 'package:quiz_car/app/features/shared/data/datasources/quiz_datasource.dart';
import 'package:quiz_car/app/features/shared/data/models/questoes_model.dart';
import 'package:quiz_car/app/features/shared/domain/entities/quiz_entity.dart';
import 'package:quiz_car/app/features/shared/domain/repositories/iquiz_repository.dart';
import 'package:quiz_car/core/exceptions/erro.dart';

class QuizRepository implements IQuizRepository {
  QuizRepository(this._datasource);
  final QuizDatasource _datasource;

  @override
  Future<Either<ExceptionErro, QuizEntity>> getQuiz(String nome) async {
    final result = await _datasource.getQuiz(nome);
    if (result.isNotEmpty) {
      return right(QuizModel.fromJson(result));
    }
    return left(ExceptionErro());
  }
}
