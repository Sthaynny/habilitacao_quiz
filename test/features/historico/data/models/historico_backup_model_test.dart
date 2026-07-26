import 'package:flutter_test/flutter_test.dart';
import 'package:habilitacao_quiz/app/features/historico/data/models/historico_backup_model.dart';
import 'package:habilitacao_quiz/app/features/historico/data/models/historico_model.dart';
import 'package:habilitacao_quiz/app/features/resultado/data/models/resultado_model.dart';
import 'package:habilitacao_quiz/app/features/resultado/domain/tipo_resultado.dart';

void main() {
  group('HistoricoBackupModel', () {
    test('serializa envelope com historico v2', () {
      final backup = HistoricoBackupModel(
        exportedAt: DateTime.utc(2026, 7, 26, 12, 0),
        historico: HistoricoModel(
          resutados: [
            ResultadoModel(
              id: 'r1',
              tipo: TipoResultado.tema,
              realizadoEm: DateTime.utc(2026, 7, 25),
              titulo: 'Legislação',
              totalPerguntas: 10,
              result: true,
              totalRespostasCorretas: 8,
              percentual: 80,
            ),
          ],
        ),
      );
      final map = backup.toMap();
      expect(map['backupVersion'], HistoricoBackupModel.backupVersion);
      expect(map['appId'], HistoricoBackupModel.appId);
      expect(map['historico'], isA<Map<String, dynamic>>());
      final roundTrip = HistoricoBackupModel.fromMap(map);
      expect(roundTrip.historico.resutados.length, 1);
      expect(roundTrip.historico.resutados.first.titulo, 'Legislação');
    });

    test('aceita JSON legado só com resutados na raiz', () {
      final legacy = HistoricoModel(
        resutados: [
          ResultadoModel(
            id: 'legacy',
            tipo: TipoResultado.simulado,
            realizadoEm: DateTime.utc(2026, 7, 26),
            titulo: 'Simulado',
            totalPerguntas: 15,
            result: true,
            totalRespostasCorretas: 12,
            percentual: 80,
          ),
        ],
      ).toMap();

      final backup = HistoricoBackupModel.fromMap(legacy);
      expect(backup.historico.resutados.length, 1);
      expect(backup.historico.resutados.first.isSimulado, isTrue);
    });

    test('fromJson inválido lança FormatException', () {
      expect(
        () => HistoricoBackupModel.fromJson('not-json'),
        throwsA(isA<FormatException>()),
      );
    });
  });
}
