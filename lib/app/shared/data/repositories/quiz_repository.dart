import 'package:dartz/dartz.dart';
import 'package:habilitacao_quiz/app/shared/data/datasources/quiz_datasource.dart';
import 'package:habilitacao_quiz/app/shared/data/models/questoes_model.dart';
import 'package:habilitacao_quiz/app/shared/domain/entities/quiz_entity.dart';
import 'package:habilitacao_quiz/app/shared/domain/repositories/iquiz_repository.dart';
import 'package:habilitacao_quiz/app/shared/domain/services/pro_gate.dart';
import 'package:habilitacao_quiz/app/shared/utils/simulado.dart';
import 'package:habilitacao_quiz/core/exceptions/erro.dart';
import 'package:habilitacao_quiz/core/utils/keys.dart';

class QuizRepository implements IQuizRepository {
  QuizRepository(this._datasource, this._proGate);

  final QuizDatasource _datasource;
  final ProGate _proGate;

  @override
  Future<Either<ExceptionErro, QuizEntity>> getQuiz(String nome) async {
    final result = await _datasource.getQuiz(nome);
    if (result.isEmpty) {
      return left(ExceptionErro());
    }
    final quiz = QuizModel.fromJson(result);
    quiz.perguntas.shuffle();
    final limit = _proGate.maxQuestoesPorSessaoTema;
    final perguntas = limit == null
        ? quiz.perguntas
        : quiz.perguntas.sublist(
            0,
            limit.clamp(0, quiz.perguntas.length),
          );
    return right(quiz.copyWith(perguntas: perguntas));
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
    if (!simulado.simuladoValido) {
      return left(ExceptionErro());
    }
    return right(
      simulado.buildSimulado(totalQuestoes: _proGate.maxQuestoesSimulado),
    );
  }
}
