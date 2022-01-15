import 'package:dartz/dartz.dart';
import 'package:quiz_car/app/features/shared/data/datasources/quiz_datasource.dart';
import 'package:quiz_car/app/features/shared/data/models/questoes_model.dart';
import 'package:quiz_car/app/features/shared/domain/entities/quiz_entity.dart';
import 'package:quiz_car/app/features/shared/domain/repositories/iquiz_repository.dart';
import 'package:quiz_car/app/features/shared/utils/simulado.dart';
import 'package:quiz_car/core/exceptions/erro.dart';
import 'package:quiz_car/core/utils/keys.dart';

class QuizRepository implements IQuizRepository {
  QuizRepository(this._datasource);
  final QuizDatasource _datasource;

  @override
  Future<Either<ExceptionErro, QuizEntity>> getQuiz(String nome) async {
    final result = await _datasource.getQuiz(nome);
    if (result.isNotEmpty) {
      final quiz = QuizModel.fromJson(result);
      quiz.perguntas.shuffle();
      return right(quiz);
    }
    return left(ExceptionErro());
  }

  @override
  Future<Either<ExceptionErro, QuizEntity>> getSimulado() async {
    final simulado = Simulado(
      jsonMecanica: await _datasource.getQuiz(Keys.mecanicaBasica),
      jsonDirecaoDefensiva: await _datasource.getQuiz(Keys.direcaoDefensiva),
      jsonPrimeirosSocorros: await _datasource.getQuiz(Keys.primeirosSocorros),
      jsonLegislacao: await _datasource.getQuiz(Keys.legislacao),
      jsonMeioAmbiente: await _datasource.getQuiz(Keys.meioAmbiente),
    );
    if (simulado.simuladoValido) {
      return right(simulado.getSimulado);
    }
    return left(ExceptionErro());
  }
}
