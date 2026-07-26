import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habilitacao_quiz/app/features/questionario/presentation/components/indicador_questoes_widget.dart';
import 'package:habilitacao_quiz/app/features/questionario/presentation/controller/questionario_controller.dart';
import 'package:habilitacao_quiz/core/styles/app_styles.dart';
import 'package:habilitacao_quiz/core/utils/strings.dart';

class AppBarQuestionarioWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const AppBarQuestionarioWidget({
    super.key,
    required this.controller,
    this.onClosed,
  });

  final QuestionarioController controller;
  final VoidCallback? onClosed;

  @override
  Size get preferredSize => const Size.fromHeight(100);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Semantics(
            button: true,
            label: Strings.fecharQuestionario,
            child: IconButton(
              tooltip: Strings.fecharQuestionario,
              icon: const Icon(Icons.close, color: AppColors.darkRed),
              onPressed: onClosed,
            ),
          ),
          Obx(
            () => IndicadorQuestoesWidget(
              currentPage: controller.indexPerguntaUsuario,
              length: controller.tamanhoQuiz,
            ),
          ),
        ],
      ),
    );
  }
}
