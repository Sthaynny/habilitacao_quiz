import 'package:flutter_test/flutter_test.dart';
import 'package:habilitacao_quiz/app/features/historico/data/models/historico_model.dart';
import 'package:habilitacao_quiz/app/features/resultado/data/models/resultado_model.dart';
import 'package:habilitacao_quiz/app/features/resultado/domain/tipo_resultado.dart';
import 'package:habilitacao_quiz/core/utils/strings.dart';

void main() {
  group('ResultadoModel migração v1', () {
    test('infere simulado e gera id a partir de titulo', () {
      final model = ResultadoModel.fromMap({
        'titulo': Strings.simulado,
        'totalPerguntas': 15,
        'totalRespostasCorretas': 12,
        'result': true,
        'percentual': 80.0,
      });
      expect(model.tipo, TipoResultado.simulado);
      expect(model.id, startsWith('legacy_'));
      expect(model.realizadoEm, isNull);
    });

    test('infere tema para quiz por titulo', () {
      final model = ResultadoModel.fromMap({
        'titulo': Strings.legislacao,
        'totalPerguntas': 10,
        'totalRespostasCorretas': 5,
        'result': false,
        'percentual': 50.0,
      });
      expect(model.tipo, TipoResultado.tema);
    });
  });

  group('HistoricoModel v2', () {
    test('serializa schemaVersion 2', () {
      final json = HistoricoModel(
        resutados: [
          ResultadoModel(
            id: 'a1',
            tipo: TipoResultado.simulado,
            realizadoEm: DateTime.utc(2026, 7, 26),
            titulo: Strings.simulado,
            totalPerguntas: 15,
            totalRespostasCorretas: 10,
            result: true,
            percentual: 66.6,
          ),
        ],
      ).toJson();
      final decoded = HistoricoModel.fromJson(json);
      expect(decoded.resutados.single.id, 'a1');
      expect(decoded.resutados.single.tipo, TipoResultado.simulado);
    });
  });
}
