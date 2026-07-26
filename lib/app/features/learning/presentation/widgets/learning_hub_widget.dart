import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habilitacao_quiz/app/features/learning/domain/learning_theme_id.dart';
import 'package:habilitacao_quiz/app/features/learning/presentation/controller/learning_controller.dart';
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
      return SafeArea(
        child: ListView(
          padding: EdgeInsets.all(AppSpacingStack.xxxSmall.value),
          children: [
            Text(
              Strings.aprenderHubTitulo,
              style: AppFontStyle.headline20Bold,
            ),
            SizedBox(height: AppSpacingStack.quarck.value),
            Text(
              Strings.avisoLegalTexto,
              style: AppFontStyle.body14Regular.setColor(AppColors.grey),
            ),
            SizedBox(height: AppSpacingStack.xxxSmall.value),
            const HabilitacaoQuizPlusCtaBanner(),
            SizedBox(height: AppSpacingStack.xxxSmall.value),
            Text(
              Strings.aprenderTemasTitulo,
              style: AppFontStyle.body16Bold,
            ),
            ...manifest.themes.map((theme) {
              final label =
                  theme.learningTheme?.displayTitle ?? theme.id;
              return ListTile(
                title: Text(label, style: AppFontStyle.body16Regular),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => Get.toNamed(
                  Routes.aprenderTema,
                  arguments: theme.id,
                ),
              );
            }),
            SizedBox(height: AppSpacingStack.xxxSmall.value),
            AppButton.primary(
              Strings.aprenderTrilha,
              onPressed: () => Get.toNamed(Routes.aprenderTrilha),
            ),
            SizedBox(height: AppSpacingStack.quarck.value),
            AppButton.secundary(
              Strings.aprenderFichas,
              onPressed: () => Get.toNamed(Routes.aprenderFichas),
            ),
            SizedBox(height: AppSpacingStack.quarck.value),
            AppButton.secundary(
              Strings.aprenderMapa,
              onPressed: () => Get.toNamed(Routes.aprenderMapa),
            ),
            if (controller.proGate.podeRevisaoEspacada) ...[
              SizedBox(height: AppSpacingStack.quarck.value),
              AppButton.secundary(
                Strings.revisaoEspacada,
                onPressed: () => Get.toNamed(Routes.aprenderRevisao),
              ),
            ],
            SizedBox(height: AppSpacingStack.quarck.value),
            AppButton.link(
              Strings.fontesOficiais,
              onPressed: () => Get.toNamed(Routes.legalNotice),
            ),
          ],
        ),
      );
    });
  }
}
