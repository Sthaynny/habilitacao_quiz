import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habilitacao_quiz/app/shared/presentation/pages/loading_blur_screen.dart';
import 'package:habilitacao_quiz/core/utils/strings.dart';

void main() {
  testWidgets('LoadingBlurScreen anuncia carregamento quando ativo',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: LoadingBlurScreen(
          enabled: true,
          child: SizedBox(),
        ),
      ),
    );

    expect(find.bySemanticsLabel(Strings.carregando), findsOneWidget);

    final semantics = tester.getSemantics(
      find.bySemanticsLabel(Strings.carregando),
    );
    expect(semantics.flagsCollection.isLiveRegion, isTrue);
  });
}
