import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habilitacao_quiz/app/features/study_reminder/data/study_reminder_datasource.dart';
import 'package:habilitacao_quiz/app/features/study_reminder/domain/study_reminder_service.dart';
import 'package:habilitacao_quiz/core/components/button.dart';
import 'package:habilitacao_quiz/core/styles/app_styles.dart';
import 'package:habilitacao_quiz/core/styles/spacing_stack.dart';
import 'package:habilitacao_quiz/core/utils/strings.dart';

/// F02 — opt-in de lembrete diário de estudo (notificação local).
class StudyReminderPromptSheet extends StatefulWidget {
  const StudyReminderPromptSheet({super.key});

  static Future<void> showIfNeeded(BuildContext context) async {
    final datasource = Get.find<StudyReminderDatasource>();
    if (await datasource.promptJaExibido()) return;
    if (!context.mounted) return;

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => const StudyReminderPromptSheet(),
    );
    await datasource.marcarPromptExibido();
  }

  @override
  State<StudyReminderPromptSheet> createState() =>
      _StudyReminderPromptSheetState();
}

class _StudyReminderPromptSheetState extends State<StudyReminderPromptSheet> {
  TimeOfDay _horario = const TimeOfDay(hour: 19, minute: 0);
  bool _busy = false;

  Future<void> _escolherHorario() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _horario,
      helpText: Strings.studyReminderEscolherHorario,
    );
    if (picked != null) {
      setState(() => _horario = picked);
    }
  }

  Future<void> _ativar() async {
    setState(() => _busy = true);
    try {
      await Get.find<StudyReminderService>().ativarLembrete(
        hour: _horario.hour,
        minute: _horario.minute,
      );
      if (mounted) Navigator.of(context).pop();
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final horarioLabel =
        '${_horario.hour.toString().padLeft(2, '0')}:${_horario.minute.toString().padLeft(2, '0')}';

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          AppSpacingStack.xxxSmall.value,
          0,
          AppSpacingStack.xxxSmall.value,
          AppSpacingStack.xxxSmall.value,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Semantics(
              header: true,
              child: Text(
                Strings.studyReminderTituloSheet,
                style: AppFontStyle.headline20Bold,
              ),
            ),
            SizedBox(height: AppSpacingStack.nano.value),
            Text(
              Strings.studyReminderSubtituloSheet,
              style: AppFontStyle.body14Regular.setColor(AppColors.grey),
            ),
            SizedBox(height: AppSpacingStack.xxxSmall.value),
            Semantics(
              button: true,
              label: '${Strings.studyReminderHorario}. $horarioLabel',
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.schedule_outlined),
                title: Text(
                  Strings.studyReminderHorario,
                  style: AppFontStyle.body16Medium,
                ),
                subtitle: Text(horarioLabel),
                onTap: _busy ? null : _escolherHorario,
              ),
            ),
            SizedBox(height: AppSpacingStack.nano.value),
            AppButton.primary(
              Strings.studyReminderAtivar,
              onPressed: _busy ? null : _ativar,
            ),
            AppButton.link(
              Strings.studyReminderAgoraNao,
              onPressed: _busy ? null : () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
}
