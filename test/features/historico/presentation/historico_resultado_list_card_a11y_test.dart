import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habilitacao_quiz/app/features/historico/presentation/widgets/historico_resultado_list_card.dart';
import 'package:habilitacao_quiz/app/features/resultado/domain/resultado_entity.dart';
import 'package:habilitacao_quiz/app/features/resultado/domain/tipo_resultado.dart';
import 'package:habilitacao_quiz/core/utils/strings.dart';

void main() {
  final resultado = ResultadoEntity(
    id: '1',
    tipo: TipoResultado.simulado,
    realizadoEm: DateTime(2026, 7, 26),
    titulo: 'Simulado CNH',
    totalPerguntas: 30,
    totalRespostasCorretas: 23,
    result: true,
    percentual: 76.7,
  );

  testWidgets('card expõe semantics de botão e altura mínima 48dp',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: HistoricoResultadoListCard(
            resultado: resultado,
            onTap: () {},
          ),
        ),
      ),
    );

    final semantics = tester.getSemantics(find.byType(InkWell));
    expect(semantics.label, contains('Simulado CNH'));
    expect(semantics.label, contains(Strings.historicoBadgeSimulado));

    final box = tester.renderObject<RenderBox>(
      find.byType(ConstrainedBox).first,
    );
    expect(box.size.height, greaterThanOrEqualTo(48));
  });
}
