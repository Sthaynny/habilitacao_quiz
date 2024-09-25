import 'package:flutter/material.dart';
import 'package:habilitacao_quiz/app/features/questionario/presentation/components/indicador_questoes_widget.dart';
import 'package:habilitacao_quiz/core/styles/app_styles.dart';

class AppBarQuestionarioWidget extends PreferredSize {
  AppBarQuestionarioWidget({
    required this.tamanhoQuiz,
    required this.paginaAtual,
    this.onClosed,
    super.key,
  }) : super(
          preferredSize: const Size.fromHeight(90),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.close,
                    color: AppColors.vermelhoEscuro,
                  ),
                  onPressed: onClosed,
                ),
                IndicadorQuestoesWidget(
                  currentPage: paginaAtual,
                  length: tamanhoQuiz,
                )
              ],
            ),
          ),
        );

  final int tamanhoQuiz;
  final int paginaAtual;
  final VoidCallback? onClosed;
}
