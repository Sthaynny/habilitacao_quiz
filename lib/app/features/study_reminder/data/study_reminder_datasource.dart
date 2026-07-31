import 'package:shared_preferences/shared_preferences.dart';

class StudyReminderDatasource {
  static const _promptShownKey = 'study_reminder_prompt_shown';
  static const _enabledKey = 'study_reminder_enabled';
  static const _hourKey = 'study_reminder_hour';
  static const _minuteKey = 'study_reminder_minute';

  Future<bool> promptJaExibido() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_promptShownKey) ?? false;
  }

  Future<void> marcarPromptExibido() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_promptShownKey, true);
  }

  Future<bool> lembreteAtivo() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_enabledKey) ?? false;
  }

  Future<({int hour, int minute})?> lerHorario() async {
    final prefs = await SharedPreferences.getInstance();
    if (!(prefs.getBool(_enabledKey) ?? false)) return null;
    final hour = prefs.getInt(_hourKey);
    final minute = prefs.getInt(_minuteKey);
    if (hour == null || minute == null) return null;
    return (hour: hour, minute: minute);
  }

  Future<void> salvarLembrete({
    required bool enabled,
    int hour = 19,
    int minute = 0,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_enabledKey, enabled);
    await prefs.setInt(_hourKey, hour);
    await prefs.setInt(_minuteKey, minute);
  }

  Future<void> desativarLembrete() => salvarLembrete(enabled: false);
}
