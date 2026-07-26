import 'package:habilitacao_quiz/app/features/resultado/domain/resultado_entity.dart';

/// Aplica regra HQ-H08: `detalhePerguntas` só persiste em simulado Pro.
ResultadoEntity resultadoParaPersistenciaHistorico(
  ResultadoEntity resultado, {
  required bool isPro,
}) {
  final mayPersistDetalhe = isPro && resultado.isSimulado;
  if (mayPersistDetalhe || resultado.detalhePerguntas == null) {
    return resultado;
  }
  return ResultadoEntity(
    id: resultado.id,
    tipo: resultado.tipo,
    realizadoEm: resultado.realizadoEm,
    titulo: resultado.titulo,
    totalPerguntas: resultado.totalPerguntas,
    result: resultado.result,
    totalRespostasCorretas: resultado.totalRespostasCorretas,
    percentual: resultado.percentual,
  );
}
