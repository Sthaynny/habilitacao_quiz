import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habilitacao_quiz/app/features/learning/domain/entities/learning_entities.dart';
import 'package:habilitacao_quiz/app/features/learning/domain/learning_theme_id.dart';
import 'package:habilitacao_quiz/app/features/learning/presentation/controller/learning_controller.dart';
import 'package:habilitacao_quiz/app/features/learning/presentation/widgets/learning_hub_hero.dart';
import 'package:habilitacao_quiz/app/features/learning/presentation/widgets/learning_study_tool_tile.dart';
import 'package:habilitacao_quiz/app/features/learning/presentation/widgets/learning_theme_card.dart';
import 'package:habilitacao_quiz/app/features/learning/presentation/widgets/learning_theme_visuals.dart';
import 'package:habilitacao_quiz/app/features/promo/presentation/widgets/habilitacao_quiz_plus_cta_banner.dart';
import 'package:habilitacao_quiz/app/features/routes/routes.dart';
import 'package:habilitacao_quiz/core/components/button.dart';
import 'package:habilitacao_quiz/core/styles/app_styles.dart';
import 'package:habilitacao_quiz/core/styles/spacing_stack.dart';
import 'package:habilitacao_quiz/core/utils/strings.dart';

class LearningHubWidget extends StatelessWidget {
  const LearningHubWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LearningController>();
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }
      final manifest = controller.manifest.value;
      if (manifest == null) {
        return Center(
          child: Text(
            Strings.erroPadrao,
            style: AppFontStyle.body16Regular,
          ),
        );
      }
      return _LearningHubLoadedContent(
        manifest: manifest,
        exibirPromoPlus: controller.proGate.exibirPromoPlus,
        podeRevisaoEspacada: controller.proGate.podeRevisaoEspacada,
        isPro: controller.proGate.isPro,
      );
    });
  }
}

class _LearningHubLoadedContent extends StatelessWidget {
  const _LearningHubLoadedContent({
    required this.manifest,
    required this.exibirPromoPlus,
    required this.podeRevisaoEspacada,
    required this.isPro,
  });

  final LearningManifestEntity manifest;
  final bool exibirPromoPlus;
  final bool podeRevisaoEspacada;
  final bool isPro;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: EdgeInsets.all(AppSpacingStack.xxxSmall.value),
        children: [
          LearningHubHero(isPro: isPro),
          SizedBox(height: AppSpacingStack.nano.value),
          if (!isPro)
            Text(
              Strings.avisoLegalTexto,
              style: AppFontStyle.body14Regular.setColor(AppColors.grey),
            ),
          if (exibirPromoPlus) ...[
            SizedBox(height: AppSpacingStack.xxxSmall.value),
            const HabilitacaoQuizPlusCtaBanner(),
          ],
          SizedBox(height: AppSpacingStack.xxSmall.value),
          if (isPro) ...[
            Text(
              Strings.aprenderFerramentasEstudo,
              style: AppFontStyle.body16Bold,
            ),
            SizedBox(height: AppSpacingStack.nano.value),
            ..._studyTools(podeRevisaoEspacada),
            SizedBox(height: AppSpacingStack.xxSmall.value),
          ],
          Text(
            Strings.aprenderTemasTitulo,
            style: AppFontStyle.body16Bold,
          ),
          SizedBox(height: AppSpacingStack.nano.value),
          _LearningThemeTopicsGrid(themes: manifest.themes),
          if (!isPro) ...[
            SizedBox(height: AppSpacingStack.xxSmall.value),
            Text(
              Strings.aprenderFerramentasEstudo,
              style: AppFontStyle.body16Bold,
            ),
            SizedBox(height: AppSpacingStack.nano.value),
            ..._studyTools(podeRevisaoEspacada),
          ],
          SizedBox(height: AppSpacingStack.xxxSmall.value),
          AppButton.link(
            Strings.fontesOficiais,
            onPressed: () => Get.toNamed(Routes.legalNotice),
          ),
          if (isPro) ...[
            SizedBox(height: AppSpacingStack.nano.value),
            Text(
              Strings.avisoLegalTexto,
              style: AppFontStyle.caption12Regular.setColor(AppColors.grey),
            ),
          ],
        ],
      ),
    );
  }

  List<Widget> _studyTools(bool revisao) {
    return [
      LearningStudyToolTile(
        title: Strings.aprenderTrilha,
        subtitle: Strings.aprenderTrilhaSubtitulo,
        icon: Icons.route_outlined,
        accentColor: AppColors.primary,
        onTap: () => Get.toNamed(Routes.aprenderTrilha),
      ),
      SizedBox(height: AppSpacingStack.nano.value),
      LearningStudyToolTile(
        title: Strings.aprenderFichas,
        subtitle: Strings.aprenderFichasSubtitulo,
        icon: Icons.style_outlined,
        accentColor: AppColors.blue,
        onTap: () => Get.toNamed(Routes.aprenderFichas),
      ),
      SizedBox(height: AppSpacingStack.nano.value),
      LearningStudyToolTile(
        title: Strings.aprenderMapa,
        subtitle: Strings.aprenderMapaSubtitulo,
        icon: Icons.insights_outlined,
        accentColor: AppColors.darkGreen,
        onTap: () => Get.toNamed(Routes.aprenderMapa),
      ),
      if (revisao) ...[
        SizedBox(height: AppSpacingStack.nano.value),
        LearningStudyToolTile(
          title: Strings.revisaoEspacada,
          subtitle: Strings.revisaoEspacadaDescricao,
          icon: Icons.replay_outlined,
          accentColor: AppColors.purple,
          onTap: () => Get.toNamed(Routes.aprenderRevisao),
        ),
      ],
    ];
  }
}

class _LearningThemeTopicsGrid extends StatelessWidget {
  const _LearningThemeTopicsGrid({required this.themes});

  final List<LearningThemeContentEntity> themes;

  @override
  Widget build(BuildContext context) {
    final spacing = AppSpacingStack.nano.value;
    return LayoutBuilder(
      builder: (context, constraints) {
        final itemWidth = (constraints.maxWidth - spacing) / 2;
        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          crossAxisAlignment: WrapCrossAlignment.start,
          children: [
            for (final theme in themes)
              SizedBox(
                width: itemWidth,
                child: LearningThemeCard(
                  title: theme.learningTheme?.displayTitle ?? theme.id,
                  subtitle: LearningThemeVisuals.teaser(theme.id),
                  imageAsset: LearningThemeVisuals.imageAsset(theme.id),
                  onTap: () => Get.toNamed(
                    Routes.aprenderTema,
                    arguments: theme.id,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
