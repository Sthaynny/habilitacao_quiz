import 'package:flutter_test/flutter_test.dart';
import 'package:habilitacao_quiz/app/shared/data/datasources/quiz_content_version_datasource.dart';
import 'package:habilitacao_quiz/app/shared/domain/services/quiz_content_version_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('QuizContentVersionService', () {
    late QuizContentVersionDatasource datasource;
    late QuizContentVersionService service;

    setUp(() {
      SharedPreferences.setMockInitialValues({});
      datasource = QuizContentVersionDatasource();
      service = QuizContentVersionService(datasource);
    });

    test('primeira sessão grava versão sem notificar', () async {
      expect(await service.detectarAtualizacaoConteudo(), isFalse);
      expect(await datasource.lerVersaoVista(), 2);
    });

    test('versão igual não notifica', () async {
      await datasource.salvarVersaoVista(2);
      expect(await service.detectarAtualizacaoConteudo(), isFalse);
    });
  });
}
