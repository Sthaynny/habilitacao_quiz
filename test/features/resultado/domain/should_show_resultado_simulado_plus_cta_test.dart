import 'package:flutter_test/flutter_test.dart';
import 'package:habilitacao_quiz/app/features/resultado/domain/resultado_entity.dart';
import 'package:habilitacao_quiz/app/features/resultado/domain/should_show_resultado_simulado_plus_cta.dart';
import 'package:habilitacao_quiz/app/features/resultado/domain/tipo_resultado.dart';
import 'package:habilitacao_quiz/app/shared/domain/services/pro_gate.dart';
import 'package:habilitacao_quiz/core/utils/strings.dart';

ResultadoEntity _resultado({
  TipoResultado tipo = TipoResultado.simulado,
  int totalPerguntas = 15,
}) =>
    ResultadoEntity(
      id: 'id',
      tipo: tipo,
      realizadoEm: DateTime(2026, 7, 26),
      titulo: tipo == TipoResultado.simulado ? Strings.simulado : 'Legislação',
      totalPerguntas: totalPerguntas,
      totalRespostasCorretas: 10,
      result: false,
      percentual: 66.67,
    );

void main() {
  test('Free simulado 15q exibe CTA', () {
    expect(
      shouldShowResultadoSimuladoPlusCta(
        resultado: _resultado(),
        proGate: StubProGate(),
      ),
      isTrue,
    );
  });

  test('Free tema não exibe CTA', () {
    expect(
      shouldShowResultadoSimuladoPlusCta(
        resultado: _resultado(tipo: TipoResultado.tema),
        proGate: StubProGate(),
      ),
      isFalse,
    );
  });

  test('Pro simulado 30q não exibe CTA', () {
    expect(
      shouldShowResultadoSimuladoPlusCta(
        resultado: _resultado(totalPerguntas: 30),
        proGate: StubProGate(isPro: true),
      ),
      isFalse,
    );
  });

  test('Free simulado acima do teto Free não exibe CTA', () {
    expect(
      shouldShowResultadoSimuladoPlusCta(
        resultado: _resultado(totalPerguntas: 30),
        proGate: StubProGate(),
      ),
      isFalse,
    );
  });
}
