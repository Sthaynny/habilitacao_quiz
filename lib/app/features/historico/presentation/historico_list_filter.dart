import 'package:habilitacao_quiz/app/features/resultado/domain/resultado_entity.dart';
import 'package:habilitacao_quiz/app/features/resultado/domain/tipo_resultado.dart';

enum HistoricoFiltroTipo { todos, simulados, temas }

enum HistoricoFiltroDesempenho { todos, aprovados, reprovados }

class HistoricoListFilter {
  const HistoricoListFilter({
    this.tipo = HistoricoFiltroTipo.todos,
    this.desempenho = HistoricoFiltroDesempenho.todos,
    this.busca = '',
  });

  final HistoricoFiltroTipo tipo;
  final HistoricoFiltroDesempenho desempenho;
  final String busca;

  static String normalizarBusca(String raw) => raw.trim().toLowerCase();
}

List<ResultadoEntity> filtrarEOrdenarHistorico(
  List<ResultadoEntity> resultados,
  HistoricoListFilter filtro,
) {
  final busca = HistoricoListFilter.normalizarBusca(filtro.busca);
  final lista = List<ResultadoEntity>.from(resultados);
  lista.sort((a, b) {
    final ta = a.realizadoEm?.millisecondsSinceEpoch ?? 0;
    final tb = b.realizadoEm?.millisecondsSinceEpoch ?? 0;
    return tb.compareTo(ta);
  });
  return lista.where((r) => _passaTipo(r, filtro.tipo)).where((r) {
    if (!_passaDesempenho(r, filtro.desempenho)) return false;
    if (busca.isEmpty) return true;
    return r.titulo.toLowerCase().contains(busca);
  }).toList();
}

bool _passaTipo(ResultadoEntity r, HistoricoFiltroTipo filtro) {
  switch (filtro) {
    case HistoricoFiltroTipo.todos:
      return true;
    case HistoricoFiltroTipo.simulados:
      return r.tipo == TipoResultado.simulado;
    case HistoricoFiltroTipo.temas:
      return r.tipo == TipoResultado.tema;
  }
}

bool _passaDesempenho(ResultadoEntity r, HistoricoFiltroDesempenho filtro) {
  switch (filtro) {
    case HistoricoFiltroDesempenho.todos:
      return true;
    case HistoricoFiltroDesempenho.aprovados:
      return r.result;
    case HistoricoFiltroDesempenho.reprovados:
      return !r.result;
  }
}
