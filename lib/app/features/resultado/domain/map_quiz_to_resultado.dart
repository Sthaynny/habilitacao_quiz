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
    final tipo = _tipoResultado(quiz);
    return ResultadoEntity(
      id: '${agora.microsecondsSinceEpoch}_${quiz.titulo.hashCode}',
      tipo: tipo,
      realizadoEm: agora,
      titulo: quiz.titulo,
      totalPerguntas: quiz.perguntas.length,
      result: aprovado,
      totalRespostasCorretas: totalPerguntasCorretas,
      percentual: percentual,
      detalhePerguntas: _detalhePro(
        quiz: quiz,
        isPro: isPro,
        tipo: tipo,
      ),
    );
  }

  static TipoResultado _tipoResultado(QuizEntity quiz) {
    if (quiz.titulo == Strings.simulado || quiz.modoProva) {
      return TipoResultado.simulado;
    }
    return TipoResultado.tema;
  }

  static List<ResultadoPerguntaDetalheEntity>? _detalhePro({
    required QuizEntity quiz,
    required bool isPro,
    required TipoResultado tipo,
  }) {
    if (!isPro) return null;
    return quiz.perguntas
        .map((p) => _mapPergunta(p, quiz: quiz, tipo: tipo))
        .toList();
  }

  static ResultadoPerguntaDetalheEntity _mapPergunta(
    PerguntaEntity p, {
    required QuizEntity quiz,
    required TipoResultado tipo,
  }) {
    final correta = p.respostas.firstWhere((r) => r.correta);
    final sel = p.respostaSelecionada;
    final materia = p.materiaTitulo ??
        (tipo == TipoResultado.tema ? quiz.titulo : null);
    return ResultadoPerguntaDetalheEntity(
      perguntaTitulo: p.titulo,
      respostaEscolhidaTitulo: sel?.titulo,
      respostaCorretaTitulo: correta.titulo,
      acertou: sel?.correta ?? false,
      materiaTitulo: materia,
    );
  }
}
