import 'package:habilitacao_quiz/app/features/resultado/domain/resultado_entity.dart';

/// Conta simulados com [ResultadoEntity.realizadoEm] na janela rolante de [dias].
int countSimuladosUltimosDias(
  Iterable<ResultadoEntity> resultados, {
  int dias = 7,
  DateTime? referencia,
}) {
  final fim = referencia ?? DateTime.now();
  final inicio = fim.subtract(Duration(days: dias));

  var total = 0;
  for (final r in resultados) {
    if (!r.isSimulado) continue;
    final quando = r.realizadoEm;
    if (quando == null) continue;
    if (!quando.isBefore(inicio) && !quando.isAfter(fim)) {
      total++;
    }
  }
  return total;
}
