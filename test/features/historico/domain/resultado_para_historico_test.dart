import 'package:flutter_test/flutter_test.dart';
import 'package:habilitacao_quiz/app/features/historico/domain/resultado_para_historico.dart';
import 'package:habilitacao_quiz/app/features/resultado/domain/resultado_entity.dart';
import 'package:habilitacao_quiz/app/features/resultado/domain/resultado_pergunta_detalhe_entity.dart';
import 'package:habilitacao_quiz/app/features/resultado/domain/tipo_resultado.dart';
import 'package:habilitacao_quiz/core/utils/strings.dart';

void main() {
  const detalhe = [
    ResultadoPerguntaDetalheEntity(
      perguntaTitulo: 'P1',
      respostaCorretaTitulo: 'A',
      respostaEscolhidaTitulo: 'A',
      acertou: true,
    ),
  ];

  ResultadoEntity base({required TipoResultado tipo}) => ResultadoEntity(
        id: 'id1',
        tipo: tipo,
        realizadoEm: DateTime.utc(2026, 7, 26),
        titulo: tipo == TipoResultado.simulado
            ? Strings.simulado
            : Strings.legislacao,
        totalPerguntas: 15,
        result: true,
        totalRespostasCorretas: 12,
        percentual: 80,
        detalhePerguntas: detalhe,
      );

  test('Pro simulado mantém detalhe', () {
    final r = resultadoParaPersistenciaHistorico(
      base(tipo: TipoResultado.simulado),
      isPro: true,
    );
    expect(r.detalhePerguntas, detalhe);
  });

  test('Free simulado remove detalhe', () {
    final r = resultadoParaPersistenciaHistorico(
      base(tipo: TipoResultado.simulado),
      isPro: false,
    );
    expect(r.detalhePerguntas, isNull);
    expect(r.id, 'id1');
  });

  test('Pro tema remove detalhe', () {
    final r = resultadoParaPersistenciaHistorico(
      base(tipo: TipoResultado.tema),
      isPro: true,
    );
    expect(r.detalhePerguntas, isNull);
  });
}
