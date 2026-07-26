import 'package:habilitacao_quiz/app/features/resultado/domain/resultado_entity.dart';
import 'package:habilitacao_quiz/app/shared/domain/services/pro_gate.dart';

/// CTA Quiz+ na tela de resultado após simulado Free (15q), alinhado a HQ-P09.
bool shouldShowResultadoSimuladoPlusCta({
  required ResultadoEntity resultado,
  required ProGate proGate,
}) {
  if (!proGate.exibirPromoPlus) return false;
  if (!resultado.isSimulado) return false;
  return resultado.totalPerguntas <= proGate.maxQuestoesSimulado;
}
