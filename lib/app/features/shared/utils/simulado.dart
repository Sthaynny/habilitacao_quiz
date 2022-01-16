import 'package:quiz_car/app/features/shared/data/models/questoes_model.dart';
import 'package:quiz_car/app/features/shared/domain/entities/pergunta_entity.dart';
import 'package:quiz_car/app/features/shared/domain/entities/quiz_entity.dart';
import 'package:quiz_car/core/utils/strings.dart';

class Simulado {
  final String jsonMecanica;
  final String jsonDirecaoDefensiva;

  final String jsonPrimeirosSocorros;

  final String jsonLegislacao;
  final String jsonMeioAmbiente;

  Simulado({
    required this.jsonMecanica,
    required this.jsonDirecaoDefensiva,
    required this.jsonPrimeirosSocorros,
    required this.jsonLegislacao,
    required this.jsonMeioAmbiente,
  });

  bool get simuladoValido =>
      jsonMecanica.isNotEmpty &&
      jsonDirecaoDefensiva.isNotEmpty &&
      jsonPrimeirosSocorros.isNotEmpty &&
      jsonLegislacao.isNotEmpty &&
      jsonMeioAmbiente.isNotEmpty;

  QuizEntity get getSimulado {
    final QuizEntity quizMecanica = QuizModel.fromJson(jsonMecanica);
    final QuizEntity quizDirecaoDefensiva =
        QuizModel.fromJson(jsonDirecaoDefensiva);
    final QuizEntity quizMeioAmbiente = QuizModel.fromJson(jsonMeioAmbiente);
    final QuizEntity quizPrimeirosSocorros =
        QuizModel.fromJson(jsonPrimeirosSocorros);
    final QuizEntity quizLegislacao = QuizModel.fromJson(jsonLegislacao);

    quizMecanica.perguntas.shuffle();
    quizDirecaoDefensiva.perguntas.shuffle();
    quizMeioAmbiente.perguntas.shuffle();
    quizPrimeirosSocorros.perguntas.shuffle();
    quizLegislacao.perguntas.shuffle();
    final List<PerguntaEntity> perguntas = [
      ...quizMecanica.perguntas.getRange(0, 2),
      ...quizDirecaoDefensiva.perguntas.getRange(0, 5),
      ...quizPrimeirosSocorros.perguntas.getRange(0, 3),
      ...quizMeioAmbiente.perguntas.getRange(0, 2),
      ...quizLegislacao.perguntas.getRange(0, 18),
    ];

    perguntas.shuffle();

    return QuizEntity(titulo: Strings.simulado, perguntas: perguntas);
  }
}
