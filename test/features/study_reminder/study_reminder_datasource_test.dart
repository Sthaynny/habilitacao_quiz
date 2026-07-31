import 'package:flutter_test/flutter_test.dart';
import 'package:habilitacao_quiz/app/features/study_reminder/data/study_reminder_datasource.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('StudyReminderDatasource', () {
    late StudyReminderDatasource datasource;

    setUp(() {
      SharedPreferences.setMockInitialValues({});
      datasource = StudyReminderDatasource();
    });

    test('prompt não exibido na primeira execução', () async {
      expect(await datasource.promptJaExibido(), isFalse);
    });

    test('salvar lembrete persiste horário', () async {
      await datasource.salvarLembrete(enabled: true, hour: 20, minute: 30);

      expect(await datasource.lembreteAtivo(), isTrue);
      final horario = await datasource.lerHorario();
      expect(horario?.hour, 20);
      expect(horario?.minute, 30);
    });

    test('desativar limpa estado ativo', () async {
      await datasource.salvarLembrete(enabled: true);
      await datasource.desativarLembrete();

      expect(await datasource.lembreteAtivo(), isFalse);
      expect(await datasource.lerHorario(), isNull);
    });
  });
}
