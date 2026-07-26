import 'package:flutter_test/flutter_test.dart';
import 'package:habilitacao_quiz/app/features/historico/presentation/historico_list_filter.dart';
import 'package:habilitacao_quiz/app/features/resultado/domain/resultado_entity.dart';
import 'package:habilitacao_quiz/app/features/resultado/domain/tipo_resultado.dart';
import 'package:habilitacao_quiz/core/utils/strings.dart';

ResultadoEntity _r({
  required String id,
  required TipoResultado tipo,
  required DateTime when,
  String? titulo,
  bool result = true,
}) =>
    ResultadoEntity(
      id: id,
      tipo: tipo,
      realizadoEm: when,
      titulo: titulo ??
          (tipo == TipoResultado.simulado
              ? Strings.simulado
              : Strings.legislacao),
      totalPerguntas: 10,
      result: result,
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
    final out = filtrarEOrdenarHistorico(
      items,
      const HistoricoListFilter(tipo: HistoricoFiltroTipo.simulados),
    );
    expect(out.map((e) => e.id).toList(), ['2', '3']);
  });

  test('busca por título ignora maiúsculas e espaços', () {
    final items = [
      _r(
        id: '1',
        tipo: TipoResultado.tema,
        when: DateTime.utc(2026, 1, 1),
        titulo: 'Legislação de trânsito',
      ),
      _r(
        id: '2',
        tipo: TipoResultado.tema,
        when: DateTime.utc(2026, 2, 1),
        titulo: 'Direção defensiva',
      ),
    ];
    final out = filtrarEOrdenarHistorico(
      items,
      const HistoricoListFilter(busca: '  LEGISLAÇÃO '),
    );
    expect(out.map((e) => e.id).toList(), ['1']);
  });

  test('filtra aprovados e reprovados', () {
    final items = [
      _r(
        id: 'ok',
        tipo: TipoResultado.simulado,
        when: DateTime.utc(2026, 3, 1),
        result: true,
      ),
      _r(
        id: 'fail',
        tipo: TipoResultado.simulado,
        when: DateTime.utc(2026, 4, 1),
        result: false,
      ),
    ];
    final aprovados = filtrarEOrdenarHistorico(
      items,
      const HistoricoListFilter(desempenho: HistoricoFiltroDesempenho.aprovados),
    );
    expect(aprovados.map((e) => e.id).toList(), ['ok']);

    final reprovados = filtrarEOrdenarHistorico(
      items,
      const HistoricoListFilter(
        desempenho: HistoricoFiltroDesempenho.reprovados,
      ),
    );
    expect(reprovados.map((e) => e.id).toList(), ['fail']);
  });

  test('combina tipo, desempenho e busca', () {
    final items = [
      _r(
        id: '1',
        tipo: TipoResultado.tema,
        when: DateTime.utc(2026, 1, 1),
        titulo: 'Legislação',
        result: true,
      ),
      _r(
        id: '2',
        tipo: TipoResultado.tema,
        when: DateTime.utc(2026, 2, 1),
        titulo: 'Legislação avançada',
        result: false,
      ),
      _r(
        id: '3',
        tipo: TipoResultado.simulado,
        when: DateTime.utc(2026, 3, 1),
        titulo: Strings.simulado,
        result: true,
      ),
    ];
    final out = filtrarEOrdenarHistorico(
      items,
      const HistoricoListFilter(
        tipo: HistoricoFiltroTipo.temas,
        desempenho: HistoricoFiltroDesempenho.aprovados,
        busca: 'legislação',
      ),
    );
    expect(out.map((e) => e.id).toList(), ['1']);
  });
}
