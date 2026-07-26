import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habilitacao_quiz/app/features/historico/domain/entities/historico_entity.dart';
import 'package:habilitacao_quiz/app/features/historico/domain/entities/materia_percentual_entity.dart';
import 'package:habilitacao_quiz/app/features/learning/presentation/controller/learning_controller.dart';
import 'package:habilitacao_quiz/app/features/routes/routes.dart';
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

    return Scaffold(
      appBar: AppBar(
        title: Text(
          Strings.aprenderMapa,
          style: AppFontStyle.headline20Bold,
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(AppSpacingStack.xxxSmall.value),
        children: [
          Text(
            mapa.dinamico
                ? Strings.aprenderMapaDinamico
                : Strings.aprenderMapaPreview,
            style: AppFontStyle.body14Regular.setColor(AppColors.grey),
          ),
          if (!mapa.dinamico)
            TextButton(
              onPressed: () => Get.toNamed(Routes.habilitacaoQuizPlus),
              child: Text(Strings.plusVerNaLoja),
            ),
          SizedBox(height: AppSpacingStack.xxxSmall.value),
          ...mapa.materias.map((m) => _MateriaBar(materia: m)),
        ],
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
    return Padding(
      padding: EdgeInsets.only(bottom: AppSpacingStack.xxxSmall.value),
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
            '${materia.percentual.toStringAsFixed(0)}% '
            '(${materia.totalCorretas}/${materia.totalQuestoes})',
            style: AppFontStyle.body14Regular.setColor(AppColors.grey),
          ),
        ],
      ),
    );
  }
}
