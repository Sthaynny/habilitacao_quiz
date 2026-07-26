import 'package:flutter_test/flutter_test.dart';
import 'package:habilitacao_quiz/app/features/historico/domain/entities/historico_entity.dart';
import 'package:habilitacao_quiz/app/features/resultado/domain/resultado_entity.dart';
import 'package:habilitacao_quiz/app/features/resultado/domain/tipo_resultado.dart';

ResultadoEntity _resultado(int index) => ResultadoEntity(
      id: 'id_$index',
      tipo: TipoResultado.tema,
      realizadoEm: DateTime.utc(2026, 1, index + 1),
      titulo: 'Quiz $index',
      totalPerguntas: 10,
      result: true,
      totalRespostasCorretas: 8,
      percentual: 80,
    );

void main() {
  group('HistoricoEntity FIFO Free', () {
    test('mantém no máximo 10 com maxResultados', () {
      final historico = HistoricoEntity(resutados: []);
      for (var i = 0; i < 12; i++) {
        historico.add(_resultado(i), maxResultados: 10);
      }
      expect(historico.resutados.length, 10);
      expect(historico.resutados.first.titulo, 'Quiz 2');
      expect(historico.resutados.last.titulo, 'Quiz 11');
    });
  });

  group('HistoricoEntity Pro', () {
    test('salva 15 resultados sem FIFO', () {
      final historico = HistoricoEntity(resutados: []);
      for (var i = 0; i < 15; i++) {
        historico.add(_resultado(i), maxResultados: null);
      }
      expect(historico.resutados.length, 15);
      expect(historico.resutados.first.titulo, 'Quiz 0');
      expect(historico.resutados.last.titulo, 'Quiz 14');
    });
  });
}
