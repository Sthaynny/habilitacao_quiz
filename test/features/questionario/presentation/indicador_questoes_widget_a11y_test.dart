import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habilitacao_quiz/app/features/questionario/presentation/components/indicador_questoes_widget.dart';
import 'package:habilitacao_quiz/core/utils/strings.dart';

void main() {
  testWidgets('IndicadorQuestoesWidget expõe label e progresso', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: IndicadorQuestoesWidget(currentPage: 3, length: 10),
        ),
      ),
    );

    final semantics = tester.getSemantics(
      find.byType(IndicadorQuestoesWidget),
    );
    expect(
      semantics.label,
      Strings.questaoIndicadorA11y(3, 10),
    );
    expect(semantics.value, Strings.questaoProgressoA11y(30));
  });
}
