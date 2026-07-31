import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';import 'package:habilitacao_quiz/app/features/questionario/presentation/components/resposta/resposta_widget.dart';
import 'package:habilitacao_quiz/app/shared/domain/entities/resposta_entity.dart';
import 'package:habilitacao_quiz/core/utils/strings.dart';

void main() {
  final resposta = RespostaEntity(titulo: 'opção a', correta: false);

  testWidgets('RespostaWidget expõe botão com rótulo e estado selecionado',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: RespostaWidget(
            resposta: resposta,
            isSelected: true,
            onTap: (_) {},
          ),
        ),
      ),
    );

    final semantics = tester.getSemantics(find.byType(RespostaWidget));
    expect(semantics.flagsCollection.isButton, isTrue);
    expect(semantics.flagsCollection.isSelected, isTrue);
    expect(semantics.label, contains('opção a'));
    expect(semantics.hint, Strings.respostaSelecionadaA11y);
  });

  testWidgets('RespostaWidget tem altura mínima de 48dp', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: RespostaWidget(
            resposta: resposta,
            onTap: (_) {},
          ),
        ),
      ),
    );

    final box = tester.renderObject<RenderBox>(find.byType(InkWell));
    expect(box.size.height, greaterThanOrEqualTo(48));
  });
}
