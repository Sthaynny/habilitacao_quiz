import 'package:flutter_test/flutter_test.dart';
import 'package:habilitacao_quiz/app/features/resultado/domain/resultado_entity.dart';
import 'package:habilitacao_quiz/app/features/resultado/domain/tipo_resultado.dart';
import 'package:habilitacao_quiz/core/analytics/simulados_periodo.dart';

ResultadoEntity _simulado(DateTime realizadoEm) => ResultadoEntity(
      id: 's_${realizadoEm.millisecondsSinceEpoch}',
      tipo: TipoResultado.simulado,
      realizadoEm: realizadoEm,
      titulo: 'Simulado',
      totalPerguntas: 15,
      result: true,
      totalRespostasCorretas: 10,
      percentual: 66,
    );

ResultadoEntity _tema(DateTime realizadoEm) => ResultadoEntity(
      id: 't_${realizadoEm.millisecondsSinceEpoch}',
      tipo: TipoResultado.tema,
      realizadoEm: realizadoEm,
      titulo: 'Legislação',
      totalPerguntas: 10,
      result: true,
      totalRespostasCorretas: 8,
      percentual: 80,
    );

void main() {
  final referencia = DateTime(2026, 7, 26, 12);

  test('conta só simulados na janela de 7 dias', () {
    final lista = [
      _simulado(referencia.subtract(const Duration(days: 1))),
      _simulado(referencia.subtract(const Duration(days: 6))),
      _simulado(referencia.subtract(const Duration(days: 8))),
      _tema(referencia),
    ];
    expect(
      countSimuladosUltimosDias(lista, referencia: referencia),
      2,
    );
  });

  test('ignora simulado sem realizadoEm', () {
    final semData = ResultadoEntity(
      id: 'x',
      tipo: TipoResultado.simulado,
      realizadoEm: null,
      titulo: 'Simulado',
      totalPerguntas: 15,
      result: true,
      totalRespostasCorretas: 10,
      percentual: 66,
    );
    expect(
      countSimuladosUltimosDias([semData], referencia: referencia),
      0,
    );
  });
}
