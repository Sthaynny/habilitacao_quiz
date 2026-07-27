import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habilitacao_quiz/app/features/questionario/presentation/components/indicador_questoes_widget.dart';
import 'package:habilitacao_quiz/app/features/questionario/presentation/controller/questionario_controller.dart';
import 'package:habilitacao_quiz/core/styles/app_styles.dart';
import 'package:habilitacao_quiz/core/utils/strings.dart';

class AppBarQuestionarioWidget extends StatefulWidget
    implements PreferredSizeWidget {
  const AppBarQuestionarioWidget({
    super.key,
    required this.controller,
    this.onClosed,
    this.tempoLimite,
    this.onTempoEsgotado,
  });

  final QuestionarioController controller;
  final VoidCallback? onClosed;
  final Duration? tempoLimite;
  final VoidCallback? onTempoEsgotado;

  @override
  Size get preferredSize => const Size.fromHeight(100);

  @override
  State<AppBarQuestionarioWidget> createState() =>
      _AppBarQuestionarioWidgetState();
}

class _AppBarQuestionarioWidgetState extends State<AppBarQuestionarioWidget> {
  Timer? _timer;
  Duration _remaining = Duration.zero;

  @override
  void initState() {
    super.initState();
    _startTimerIfNeeded();
  }

  @override
  void didUpdateWidget(covariant AppBarQuestionarioWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.tempoLimite != widget.tempoLimite) {
      _startTimerIfNeeded();
    }
  }

  void _startTimerIfNeeded() {
    final limit = widget.tempoLimite;
    _timer?.cancel();
    if (limit == null) return;
    _remaining = limit;
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      setState(() {
        _remaining -= const Duration(seconds: 1);
        if (_remaining <= Duration.zero) {
          _timer?.cancel();
          widget.onTempoEsgotado?.call();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _formatTimer(Duration d) {
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    final timerLabel =
        widget.tempoLimite != null ? _formatTimer(_remaining) : null;

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (timerLabel != null)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      '${Strings.modoProvaTimer}: $timerLabel',
                      style: AppFontStyle.body14Bold,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              Semantics(
                button: true,
                label: Strings.fecharQuestionario,
                child: IconButton(
                  tooltip: Strings.fecharQuestionario,
                  icon: const Icon(Icons.close, color: AppColors.darkRed),
                  onPressed: widget.onClosed,
                ),
              ),
            ],
          ),
          Obx(
            () => IndicadorQuestoesWidget(
              currentPage: widget.controller.indexPerguntaUsuario,
              length: widget.controller.tamanhoQuiz,
            ),
          ),
        ],
      ),
    );
  }
}
