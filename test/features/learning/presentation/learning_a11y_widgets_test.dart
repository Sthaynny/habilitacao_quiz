import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habilitacao_quiz/app/features/learning/presentation/widgets/learning_markdown_body.dart';
import 'package:habilitacao_quiz/app/features/learning/presentation/widgets/learning_study_tool_tile.dart';
import 'package:habilitacao_quiz/app/features/learning/presentation/widgets/learning_theme_card.dart';
import 'package:habilitacao_quiz/core/styles/app_images.dart';
import 'package:habilitacao_quiz/core/utils/strings.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('LearningThemeCard expõe semantics e altura mínima 48dp',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: LearningThemeCard(
            title: Strings.aprenderTrilha,
            subtitle: Strings.aprenderTrilhaSubtitulo,
            imageAsset: AppImages.legislacao,
            onTap: () {},
          ),
        ),
      ),
    );

    final semantics = tester.getSemantics(find.byType(InkWell));
    expect(
      semantics.label,
      '${Strings.aprenderTrilha}. ${Strings.aprenderTrilhaSubtitulo}',
    );

    final box = tester.renderObject<RenderBox>(
      find.byType(ConstrainedBox).first,
    );
    expect(box.size.height, greaterThanOrEqualTo(48));
  });

  testWidgets('LearningStudyToolTile bloqueado inclui hint Quiz+',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: LearningStudyToolTile(
            title: Strings.aprenderFichas,
            subtitle: Strings.aprenderFichaPro,
            icon: Icons.article_outlined,
            trailingLocked: true,
            onTap: () {},
          ),
        ),
      ),
    );

    final semantics = tester.getSemantics(find.byType(InkWell));
    expect(semantics.hint, Strings.plusBannerHint);
  });

  testWidgets('LearningMarkdownBody marca h1 como cabeçalho', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: LearningMarkdownBody(data: '# Título do artigo\n\nParágrafo.'),
          ),
        ),
      ),
    );

    final header = tester.getSemantics(find.text('Título do artigo'));
    expect(header.label, 'Título do artigo');
  });

  testWidgets('LearningThemeCard não clipa com TextScaler 2.0', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: MediaQuery(
          data: const MediaQueryData(textScaler: TextScaler.linear(2.0)),
          child: Scaffold(
            body: SizedBox(
              width: 160,
              child: LearningThemeCard(
                title: 'Legislação de trânsito para prova teórica',
                subtitle: 'CTB, normas e placas de sinalização',
                imageAsset: AppImages.legislacao,
                onTap: () {},
              ),
            ),
          ),
        ),
      ),
    );

    expect(tester.takeException(), isNull);
  });
}
