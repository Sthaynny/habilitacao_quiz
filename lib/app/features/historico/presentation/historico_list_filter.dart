import 'package:habilitacao_quiz/app/features/resultado/domain/resultado_entity.dart';
import 'package:habilitacao_quiz/app/features/resultado/domain/tipo_resultado.dart';

enum HistoricoFiltroTipo { todos, simulados, temas }

List<ResultadoEntity> filtrarEOrdenarHistorico(
  List<ResultadoEntity> resultados,
  HistoricoFiltroTipo filtro,
) {
  final lista = List<ResultadoEntity>.from(resultados);
  lista.sort((a, b) {
    final ta = a.realizadoEm?.millisecondsSinceEpoch ?? 0;
    final tb = b.realizadoEm?.millisecondsSinceEpoch ?? 0;
    return tb.compareTo(ta);
  });
  return lista.where((r) {
    switch (filtro) {
      case HistoricoFiltroTipo.todos:
        return true;
      case HistoricoFiltroTipo.simulados:
        return r.tipo == TipoResultado.simulado;
      case HistoricoFiltroTipo.temas:
        return r.tipo == TipoResultado.tema;
    }
  }).toList();
}
