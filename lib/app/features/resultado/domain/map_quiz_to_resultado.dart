import 'package:habilitacao_quiz/app/features/resultado/domain/resultado_entity.dart';
import 'package:habilitacao_quiz/app/features/resultado/domain/resultado_pergunta_detalhe_entity.dart';
import 'package:habilitacao_quiz/app/features/resultado/domain/tipo_resultado.dart';
import 'package:habilitacao_quiz/app/shared/domain/entities/pergunta_entity.dart';
import 'package:habilitacao_quiz/app/shared/domain/entities/quiz_entity.dart';
import 'package:habilitacao_quiz/core/utils/strings.dart';

/// Monta [ResultadoEntity] ao finalizar um questionário.
class MapQuizToResultado {
  const MapQuizToResultado._();

  static ResultadoEntity call({
    required QuizEntity quiz,
    required int totalPerguntasCorretas,
    required double percentual,
    required bool aprovado,
    required bool isPro,
    DateTime? realizadoEm,
  }) {
    final agora = realizadoEm ?? DateTime.now();
    final tipo = quiz.titulo == Strings.simulado
        ? TipoResultado.simulado
        : TipoResultado.tema;
    return ResultadoEntity(
      id: '${agora.microsecondsSinceEpoch}_${quiz.titulo.hashCode}',
      tipo: tipo,
      realizadoEm: agora,
      titulo: quiz.titulo,
      totalPerguntas: quiz.perguntas.length,
      result: aprovado,
      totalRespostasCorretas: totalPerguntasCorretas,
      percentual: percentual,
      detalhePerguntas: _detalheSimuladoPro(
        quiz: quiz,
        isPro: isPro,
        tipo: tipo,
      ),
    );
  }

  static List<ResultadoPerguntaDetalheEntity>? _detalheSimuladoPro({
    required QuizEntity quiz,
    required bool isPro,
    required TipoResultado tipo,
  }) {
    if (!isPro || tipo != TipoResultado.simulado) return null;
    return quiz.perguntas.map(_mapPergunta).toList();
  }

  static ResultadoPerguntaDetalheEntity _mapPergunta(PerguntaEntity p) {
    final correta = p.respostas.firstWhere((r) => r.correta);
    final sel = p.respostaSelecionada;
    return ResultadoPerguntaDetalheEntity(
      perguntaTitulo: p.titulo,
      respostaEscolhidaTitulo: sel?.titulo,
      respostaCorretaTitulo: correta.titulo,
      acertou: sel?.correta ?? false,
    );
  }
}
