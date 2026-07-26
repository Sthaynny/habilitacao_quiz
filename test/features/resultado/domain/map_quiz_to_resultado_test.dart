import 'package:flutter_test/flutter_test.dart';
import 'package:habilitacao_quiz/app/features/resultado/domain/map_quiz_to_resultado.dart';
import 'package:habilitacao_quiz/app/features/resultado/domain/tipo_resultado.dart';
import 'package:habilitacao_quiz/app/shared/domain/entities/pergunta_entity.dart';
import 'package:habilitacao_quiz/app/shared/domain/entities/quiz_entity.dart';
import 'package:habilitacao_quiz/app/shared/domain/entities/resposta_entity.dart';
import 'package:habilitacao_quiz/core/utils/strings.dart';

void main() {
  final quizTema = QuizEntity(
    titulo: Strings.legislacao,
    perguntas: [
      PerguntaEntity(
        titulo: 'P1',
        respostas: [
          RespostaEntity(titulo: 'A', correta: true),
          RespostaEntity(titulo: 'B'),
        ],
        respostaSelecionada: RespostaEntity(titulo: 'A', correta: true),
      ),
    ],
  );

  test('define tipo tema e realizadoEm', () {
    final when = DateTime.utc(2026, 7, 26, 12);
    final r = MapQuizToResultado.call(
      quiz: quizTema,
      totalPerguntasCorretas: 1,
      percentual: 100,
      aprovado: true,
      isPro: false,
      realizadoEm: when,
    );
    expect(r.tipo, TipoResultado.tema);
    expect(r.realizadoEm, when);
    expect(r.detalhePerguntas, isNull);
  });

  test('simulado Pro inclui detalhe de gabarito', () {
    final simulado = QuizEntity(
      titulo: Strings.simulado,
      perguntas: quizTema.perguntas,
    );
    final r = MapQuizToResultado.call(
      quiz: simulado,
      totalPerguntasCorretas: 1,
      percentual: 100,
      aprovado: true,
      isPro: true,
    );
    expect(r.tipo, TipoResultado.simulado);
    expect(r.detalhePerguntas, isNotNull);
    expect(r.detalhePerguntas!.single.acertou, isTrue);
  });

  test('simulado Free não inclui detalhe', () {
    final simulado = QuizEntity(
      titulo: Strings.simulado,
      perguntas: quizTema.perguntas,
    );
    final r = MapQuizToResultado.call(
      quiz: simulado,
      totalPerguntasCorretas: 1,
      percentual: 100,
      aprovado: true,
      isPro: false,
    );
    expect(r.tipo, TipoResultado.simulado);
    expect(r.detalhePerguntas, isNull);
  });

  test('simulado Pro inclui materiaTitulo no detalhe', () {
    final simulado = QuizEntity(
      titulo: Strings.simulado,
      perguntas: [
        PerguntaEntity(
          titulo: 'P1',
          respostas: [RespostaEntity(titulo: 'A', correta: true)],
          respostaSelecionada: RespostaEntity(titulo: 'A', correta: true),
          materiaTitulo: Strings.legislacao,
        ),
      ],
    );
    final r = MapQuizToResultado.call(
      quiz: simulado,
      totalPerguntasCorretas: 1,
      percentual: 100,
      aprovado: true,
      isPro: true,
    );
    expect(r.detalhePerguntas!.single.materiaTitulo, Strings.legislacao);
  });
}
