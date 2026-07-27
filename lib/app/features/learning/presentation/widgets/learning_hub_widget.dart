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
      );
    });
  }
}

class _LearningHubLoadedContent extends StatelessWidget {
  const _LearningHubLoadedContent({
    required this.manifest,
    required this.exibirPromoPlus,
    required this.podeRevisaoEspacada,
  });

  final LearningManifestEntity manifest;
  final bool exibirPromoPlus;
  final bool podeRevisaoEspacada;

  static final _themeGridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    crossAxisSpacing: AppSpacingStack.nano.value,
    mainAxisSpacing: AppSpacingStack.nano.value,
    childAspectRatio: 0.82,
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: EdgeInsets.all(AppSpacingStack.xxxSmall.value),
        children: [
          const LearningHubHero(),
          SizedBox(height: AppSpacingStack.nano.value),
          Text(
            Strings.avisoLegalTexto,
            style: AppFontStyle.body14Regular.setColor(AppColors.grey),
          ),
          if (exibirPromoPlus) ...[
            SizedBox(height: AppSpacingStack.xxxSmall.value),
            const HabilitacaoQuizPlusCtaBanner(),
          ],
          SizedBox(height: AppSpacingStack.xxSmall.value),
          Text(
            Strings.aprenderTemasTitulo,
            style: AppFontStyle.body16Bold,
          ),
          SizedBox(height: AppSpacingStack.nano.value),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: _themeGridDelegate,
            itemCount: manifest.themes.length,
            itemBuilder: (context, index) {
              final theme = manifest.themes[index];
              final label = theme.learningTheme?.displayTitle ?? theme.id;
              return LearningThemeCard(
                title: label,
                subtitle: LearningThemeVisuals.teaser(theme.id),
                imageAsset: LearningThemeVisuals.imageAsset(theme.id),
                onTap: () => Get.toNamed(
                  Routes.aprenderTema,
                  arguments: theme.id,
                ),
              );
            },
          ),
          SizedBox(height: AppSpacingStack.xxSmall.value),
          Text(
            Strings.aprenderFerramentasEstudo,
            style: AppFontStyle.body16Bold,
          ),
          SizedBox(height: AppSpacingStack.nano.value),
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
          if (podeRevisaoEspacada) ...[
            SizedBox(height: AppSpacingStack.nano.value),
            LearningStudyToolTile(
              title: Strings.revisaoEspacada,
              subtitle: Strings.revisaoEspacadaDescricao,
              icon: Icons.replay_outlined,
              accentColor: AppColors.purple,
              onTap: () => Get.toNamed(Routes.aprenderRevisao),
            ),
          ],
          SizedBox(height: AppSpacingStack.xxxSmall.value),
          AppButton.link(
            Strings.fontesOficiais,
            onPressed: () => Get.toNamed(Routes.legalNotice),
          ),
        ],
      ),
    );
  }
}
