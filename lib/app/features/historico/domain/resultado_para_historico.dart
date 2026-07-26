import 'package:habilitacao_quiz/app/features/resultado/domain/resultado_entity.dart';

/// Free nunca persiste gabarito; Pro mantém [detalhePerguntas] (H08 + T26).
ResultadoEntity resultadoParaPersistenciaHistorico(
  ResultadoEntity resultado, {
  required bool isPro,
}) {
  if (isPro || resultado.detalhePerguntas == null) {
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
