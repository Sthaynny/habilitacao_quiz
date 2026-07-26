import 'dart:convert';

import 'package:habilitacao_quiz/app/features/historico/data/models/historico_model.dart';
import 'package:habilitacao_quiz/app/features/historico/domain/entities/historico_entity.dart';

/// Arquivo de backup Pro — envelope em torno do JSON v2 do histórico.
class HistoricoBackupModel {
  HistoricoBackupModel({
    required this.exportedAt,
    required this.historico,
  });

  static const int backupVersion = 1;
  static const String appId = 'habilitacao_quiz';

  final DateTime exportedAt;
  final HistoricoModel historico;

  factory HistoricoBackupModel.fromEntity(HistoricoEntity entity) {
    return HistoricoBackupModel(
      exportedAt: DateTime.now().toUtc(),
      historico: HistoricoModel.fromEntity(entity),
    );
  }

  Map<String, dynamic> toMap() => {
        'backupVersion': backupVersion,
        'appId': appId,
        'exportedAt': exportedAt.toIso8601String(),
        'historico': historico.toMap(),
      };

  String toJson() => json.encode(toMap());

  factory HistoricoBackupModel.fromMap(Map<String, dynamic> map) {
    final historicoMap = _extractHistoricoMap(map);
    return HistoricoBackupModel(
      exportedAt: _parseExportedAt(map['exportedAt']),
      historico: HistoricoModel.fromMap(historicoMap),
    );
  }

  factory HistoricoBackupModel.fromJson(String source) {
    final decoded = json.decode(source);
    if (decoded is! Map<String, dynamic>) {
      throw const FormatException('backup_invalid');
    }
    return HistoricoBackupModel.fromMap(decoded);
  }

  static Map<String, dynamic> _extractHistoricoMap(Map<String, dynamic> map) {
    final nested = map['historico'];
    if (nested is Map<String, dynamic>) {
      return nested;
    }
    if (map.containsKey('resutados')) {
      return map;
    }
    throw const FormatException('backup_invalid');
  }

  static DateTime _parseExportedAt(Object? value) {
    if (value is String) {
      return DateTime.tryParse(value) ?? DateTime.now().toUtc();
    }
    return DateTime.now().toUtc();
  }
}
