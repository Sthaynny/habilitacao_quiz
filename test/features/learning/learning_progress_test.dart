import 'package:flutter_test/flutter_test.dart';
import 'package:habilitacao_quiz/app/features/learning/data/datasources/learning_datasource.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('trilha progresso persiste em SharedPreferences', () async {
    SharedPreferences.setMockInitialValues({});
    final ds = LearningDatasource();
    await ds.salvarPassoTrilha(trilhaId: 'trilha_basica', stepId: 'tb_01');
    final progresso = await ds.loadTrilhaProgresso('trilha_basica');
    expect(progresso, contains('tb_01'));
  });
}
