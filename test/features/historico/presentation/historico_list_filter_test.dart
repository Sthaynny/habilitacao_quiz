import 'package:flutter_test/flutter_test.dart';
import 'package:habilitacao_quiz/app/features/historico/presentation/historico_list_filter.dart';
import 'package:habilitacao_quiz/app/features/resultado/domain/resultado_entity.dart';
import 'package:habilitacao_quiz/app/features/resultado/domain/tipo_resultado.dart';
import 'package:habilitacao_quiz/core/utils/strings.dart';

ResultadoEntity _r({
  required String id,
  required TipoResultado tipo,
  required DateTime when,
}) =>
    ResultadoEntity(
      id: id,
      tipo: tipo,
      realizadoEm: when,
      titulo: tipo == TipoResultado.simulado
          ? Strings.simulado
          : Strings.legislacao,
      totalPerguntas: 10,
      result: true,
      totalRespostasCorretas: 8,
      percentual: 80,
    );

void main() {
  test('filtra simulados e ordena do mais recente', () {
    final items = [
      _r(id: '1', tipo: TipoResultado.tema, when: DateTime.utc(2026, 1, 1)),
      _r(id: '2', tipo: TipoResultado.simulado, when: DateTime.utc(2026, 7, 1)),
      _r(id: '3', tipo: TipoResultado.simulado, when: DateTime.utc(2026, 6, 1)),
    ];
    final out =
        filtrarEOrdenarHistorico(items, HistoricoFiltroTipo.simulados);
    expect(out.map((e) => e.id).toList(), ['2', '3']);
  });
}
