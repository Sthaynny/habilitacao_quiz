import 'package:flutter_test/flutter_test.dart';
import 'package:habilitacao_quiz/app/features/historico/domain/agregar_percentual_por_materia.dart';
import 'package:habilitacao_quiz/app/features/resultado/domain/resultado_entity.dart';
import 'package:habilitacao_quiz/app/features/resultado/domain/resultado_pergunta_detalhe_entity.dart';
import 'package:habilitacao_quiz/app/features/resultado/domain/tipo_resultado.dart';
import 'package:habilitacao_quiz/core/utils/strings.dart';

ResultadoEntity _resultado({
  required TipoResultado tipo,
  required String titulo,
  int corretas = 0,
  int total = 1,
  List<ResultadoPerguntaDetalheEntity>? detalhe,
}) {
  return ResultadoEntity(
    id: 'id_$titulo',
    tipo: tipo,
    realizadoEm: DateTime.utc(2026, 7, 26),
    titulo: titulo,
    totalPerguntas: total,
    result: corretas >= total * 0.7,
    totalRespostasCorretas: corretas,
    percentual: total > 0 ? (corretas / total) * 100 : 0,
    detalhePerguntas: detalhe,
  );
}

void main() {
  test('agrega tema por título de matéria', () {
    final stats = agregarPercentualPorMateria([
      _resultado(
        tipo: TipoResultado.tema,
        titulo: Strings.legislacao,
        corretas: 8,
        total: 10,
      ),
    ]);

    final legislacao = stats.firstWhere((s) => s.titulo == Strings.legislacao);
    expect(legislacao.totalQuestoes, 10);
    expect(legislacao.totalCorretas, 8);
    expect(legislacao.percentual, 80);
  });

  test('agrega simulado Pro por materiaTitulo no detalhe', () {
    final stats = agregarPercentualPorMateria([
      _resultado(
        tipo: TipoResultado.simulado,
        titulo: Strings.simulado,
        detalhe: [
          ResultadoPerguntaDetalheEntity(
            perguntaTitulo: 'P1',
            respostaCorretaTitulo: 'A',
            acertou: true,
            materiaTitulo: Strings.mecanicaBasica,
          ),
          ResultadoPerguntaDetalheEntity(
            perguntaTitulo: 'P2',
            respostaCorretaTitulo: 'B',
            acertou: false,
            materiaTitulo: Strings.mecanicaBasica,
          ),
          ResultadoPerguntaDetalheEntity(
            perguntaTitulo: 'P3',
            respostaCorretaTitulo: 'C',
            acertou: true,
            materiaTitulo: Strings.legislacao,
          ),
        ],
      ),
    ]);

    final mecanica =
        stats.firstWhere((s) => s.titulo == Strings.mecanicaBasica);
    expect(mecanica.totalQuestoes, 2);
    expect(mecanica.totalCorretas, 1);
    expect(mecanica.percentual, 50);

    final legislacao = stats.firstWhere((s) => s.titulo == Strings.legislacao);
    expect(legislacao.totalQuestoes, 1);
    expect(legislacao.percentual, 100);
  });

  test('retorna cinco matérias mesmo sem dados', () {
    final stats = agregarPercentualPorMateria([]);
    expect(stats.length, 5);
    expect(stats.every((s) => s.totalQuestoes == 0), isTrue);
  });
}
