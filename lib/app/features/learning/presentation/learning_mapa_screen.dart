import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habilitacao_quiz/app/features/historico/domain/entities/historico_entity.dart';
import 'package:habilitacao_quiz/app/features/historico/domain/entities/materia_percentual_entity.dart';
import 'package:habilitacao_quiz/app/features/learning/presentation/controller/learning_controller.dart';
import 'package:habilitacao_quiz/app/features/learning/presentation/widgets/learning_promo_link.dart';
import 'package:habilitacao_quiz/app/features/routes/routes.dart';
import 'package:habilitacao_quiz/core/components/section_header_a11y.dart';
import 'package:habilitacao_quiz/core/styles/app_styles.dart';
import 'package:habilitacao_quiz/core/styles/spacing_stack.dart';
import 'package:habilitacao_quiz/core/utils/strings.dart';

class LearningMapaScreen extends StatelessWidget {
  const LearningMapaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LearningController>();
    final historico = Get.find<HistoricoEntity>();
    final mapa = controller.mapaUsecase(historico);

    final introItemCount = mapa.dinamico ? 2 : 3;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          Strings.aprenderMapa,
          style: AppFontStyle.headline20Bold,
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(AppSpacingStack.xxxSmall.value),
        itemCount: introItemCount + mapa.materias.length,
        itemBuilder: (context, index) {
          if (index == 0) {
            return SectionHeaderA11y(
              title: mapa.dinamico
                  ? Strings.aprenderMapaDinamico
                  : Strings.aprenderMapaPreview,
              style: AppFontStyle.body14Regular.setColor(AppColors.grey),
            );
          }
          if (!mapa.dinamico && index == 1) {
            return LearningPromoLink(
              onPressed: () => Get.toNamed(Routes.habilitacaoQuizPlus),
            );
          }
          final spacerIndex = mapa.dinamico ? 1 : 2;
          if (index == spacerIndex) {
            return SizedBox(height: AppSpacingStack.xxxSmall.value);
          }
          final materia = mapa.materias[index - introItemCount];
          return _MateriaBar(materia: materia);
        },
      ),
    );
  }
}

class _MateriaBar extends StatelessWidget {
  const _MateriaBar({required this.materia});

  final MateriaPercentualEntity materia;

  @override
  Widget build(BuildContext context) {
    final pct = materia.percentual.clamp(0, 100) / 100;
    final pctLabel = '${materia.percentual.toStringAsFixed(0)}% '
        '(${materia.totalCorretas}/${materia.totalQuestoes})';

    return Padding(
      padding: EdgeInsets.only(bottom: AppSpacingStack.xxxSmall.value),
      child: Semantics(
        label: '${materia.titulo}. $pctLabel',
        child: ExcludeSemantics(
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(materia.titulo, style: AppFontStyle.body16Regular),
            LinearProgressIndicator(
              value: pct,
              minHeight: 8,
              borderRadius: BorderRadius.circular(4),
            ),
            Text(
              pctLabel,
              style: AppFontStyle.body14Regular.setColor(AppColors.grey),
            ),
          ],
        ),
        ),
      ),
    );
  }
}
