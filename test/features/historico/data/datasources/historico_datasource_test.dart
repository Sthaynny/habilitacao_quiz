import 'package:flutter_test/flutter_test.dart';
import 'package:habilitacao_quiz/app/features/historico/data/datasources/historico_datasource.dart';
import 'package:habilitacao_quiz/app/features/historico/domain/entities/historico_entity.dart';
import 'package:habilitacao_quiz/app/features/historico/domain/resultado_para_historico.dart';
import 'package:habilitacao_quiz/app/features/resultado/domain/resultado_entity.dart';
import 'package:habilitacao_quiz/app/features/resultado/domain/resultado_pergunta_detalhe_entity.dart';
import 'package:habilitacao_quiz/app/features/resultado/domain/tipo_resultado.dart';
import 'package:habilitacao_quiz/core/utils/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  ResultadoEntity simuladoComDetalhe() => ResultadoEntity(
        id: 'ds1',
        tipo: TipoResultado.simulado,
        realizadoEm: DateTime.utc(2026, 7, 26),
        titulo: Strings.simulado,
        totalPerguntas: 30,
        result: true,
        totalRespostasCorretas: 25,
        percentual: 83.3,
        detalhePerguntas: const [
          ResultadoPerguntaDetalheEntity(
            perguntaTitulo: 'P',
            respostaCorretaTitulo: 'C',
            acertou: false,
          ),
        ],
      );

  group('HistoricoDatasource', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
    });

    test('persiste detalhe após sanitização Pro (HQ-H08)', () async {
      final ds = HistoricoDatasource();
      final historico = HistoricoEntity(resutados: []);
      historico.add(
        resultadoParaPersistenciaHistorico(simuladoComDetalhe(), isPro: true),
      );
      expect(await ds.saveHistorico(historico), isTrue);

      final loaded = await ds.getHistorico();
      expect(loaded.resutados.single.detalhePerguntas, isNotNull);
      expect(loaded.resutados.single.detalhePerguntas!.single.acertou, false);
    });

    test('Free sanitizado não grava detalhePerguntas no storage', () async {
      final ds = HistoricoDatasource();
      final historico = HistoricoEntity(resutados: []);
      historico.add(
        resultadoParaPersistenciaHistorico(simuladoComDetalhe(), isPro: false),
      );
      await ds.saveHistorico(historico);

      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString('historico');
      expect(raw, isNotNull);
      expect(raw!.contains('detalhePerguntas'), isFalse);

      final loaded = await ds.getHistorico();
      expect(loaded.resutados.single.detalhePerguntas, isNull);
    });
  });
}
