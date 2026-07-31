import 'package:flutter_test/flutter_test.dart';
import 'package:habilitacao_quiz/app/features/onboarding/data/onboarding_datasource.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('OnboardingDatasource', () {
    late OnboardingDatasource datasource;

    setUp(() {
      SharedPreferences.setMockInitialValues({});
      datasource = OnboardingDatasource();
    });

    test('onboarding não concluído na primeira execução', () async {
      expect(await datasource.materiaOnboardingConcluido(), isFalse);
      expect(await datasource.lerMateriaFoco(), isNull);
    });

    test('salvar matéria foco marca onboarding concluído', () async {
      await datasource.salvarMateriaFoco('legislacao');

      expect(await datasource.materiaOnboardingConcluido(), isTrue);
      expect(await datasource.lerMateriaFoco(), 'legislacao');
    });

    test('pular onboarding sem salvar foco', () async {
      await datasource.pularOnboardingMateria();

      expect(await datasource.materiaOnboardingConcluido(), isTrue);
      expect(await datasource.lerMateriaFoco(), isNull);
    });
  });
}
