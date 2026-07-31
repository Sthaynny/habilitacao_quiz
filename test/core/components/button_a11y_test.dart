import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habilitacao_quiz/core/components/button.dart';
import 'package:habilitacao_quiz/core/utils/strings.dart';

void main() {
  testWidgets('AppButton.primary expõe semantics de botão com rótulo',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AppButton.primary(
            Strings.voltar,
            onPressed: () {},
          ),
        ),
      ),
    );

    final semantics = tester.getSemantics(find.byType(AppButton));
    expect(semantics.hasFlag(SemanticsFlag.isButton), isTrue);
    expect(semantics.label, Strings.voltar);
  });
}
