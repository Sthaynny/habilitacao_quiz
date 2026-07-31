import 'package:habilitacao_quiz/app/features/study_reminder/data/local_study_notification_service.dart';
import 'package:habilitacao_quiz/app/features/study_reminder/data/study_reminder_datasource.dart';

class StudyReminderService {
  StudyReminderService(this._datasource, this._notifications);

  final StudyReminderDatasource _datasource;
  final LocalStudyNotificationService _notifications;

  Future<void> ativarLembrete({int hour = 19, int minute = 0}) async {
    final granted = await _notifications.requestPermissionIfNeeded();
    if (!granted) return;

    await _datasource.salvarLembrete(enabled: true, hour: hour, minute: minute);
    await _notifications.scheduleDaily(hour: hour, minute: minute);
  }

  Future<void> desativarLembrete() async {
    await _datasource.desativarLembrete();
    await _notifications.cancel();
  }

  Future<void> reagendarSeAtivo() async {
    final horario = await _datasource.lerHorario();
    if (horario == null) return;
    await _notifications.scheduleDaily(
      hour: horario.hour,
      minute: horario.minute,
    );
  }
}
