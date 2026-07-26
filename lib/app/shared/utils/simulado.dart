import 'package:habilitacao_quiz/app/shared/data/models/questoes_model.dart';
import 'package:habilitacao_quiz/app/shared/domain/entities/pergunta_entity.dart';
import 'package:habilitacao_quiz/app/shared/domain/entities/quiz_entity.dart';
import 'package:habilitacao_quiz/core/utils/strings.dart';

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

  /// Monta simulado com [totalQuestoes] (15 Free ou 30 Pro), mantendo proporção por matéria.
  QuizEntity buildSimulado({required int totalQuestoes}) {
    final buckets = totalQuestoes == 30
        ? const _SimuladoBuckets(
            mecanica: 2,
            direcaoDefensiva: 5,
            primeirosSocorros: 3,
            meioAmbiente: 2,
            legislacao: 18,
          )
        : const _SimuladoBuckets(
            mecanica: 1,
            direcaoDefensiva: 2,
            primeirosSocorros: 2,
            meioAmbiente: 1,
            legislacao: 9,
          );

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
      ..._takeTagged(quizMecanica.perguntas, buckets.mecanica, quizMecanica.titulo),
      ..._takeTagged(
        quizDirecaoDefensiva.perguntas,
        buckets.direcaoDefensiva,
        quizDirecaoDefensiva.titulo,
      ),
      ..._takeTagged(
        quizPrimeirosSocorros.perguntas,
        buckets.primeirosSocorros,
        quizPrimeirosSocorros.titulo,
      ),
      ..._takeTagged(
        quizMeioAmbiente.perguntas,
        buckets.meioAmbiente,
        quizMeioAmbiente.titulo,
      ),
      ..._takeTagged(
        quizLegislacao.perguntas,
        buckets.legislacao,
        quizLegislacao.titulo,
      ),
    ];

    perguntas.shuffle();

    return QuizEntity(titulo: Strings.simulado, perguntas: perguntas);
  }

  List<PerguntaEntity> _take(List<PerguntaEntity> source, int count) {
    if (source.length <= count) return List<PerguntaEntity>.from(source);
    return source.sublist(0, count);
  }

  List<PerguntaEntity> _takeTagged(
    List<PerguntaEntity> source,
    int count,
    String materiaTitulo,
  ) {
    return _take(source, count)
        .map((p) => p.copyWith(materiaTitulo: materiaTitulo))
        .toList();
  }
}

class _SimuladoBuckets {
  const _SimuladoBuckets({
    required this.mecanica,
    required this.direcaoDefensiva,
    required this.primeirosSocorros,
    required this.meioAmbiente,
    required this.legislacao,
  });

  final int mecanica;
  final int direcaoDefensiva;
  final int primeirosSocorros;
  final int meioAmbiente;
  final int legislacao;
}
