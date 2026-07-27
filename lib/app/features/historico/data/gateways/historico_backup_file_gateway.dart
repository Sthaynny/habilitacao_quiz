import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:habilitacao_quiz/app/features/historico/domain/services/ihistorico_backup_file_gateway.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class HistoricoBackupFileGateway implements IHistoricoBackupFileGateway {
  static const _backupFileName = 'habilitacao_quiz_historico_backup.json';

  @override
  Future<void> shareBackupFile({required String jsonContent}) async {
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/$_backupFileName');
    await file.writeAsString(jsonContent, flush: true);
    await SharePlus.instance.share(
      ShareParams(
        files: [
          XFile(
            file.path,
            mimeType: 'application/json',
            name: _backupFileName,
          ),
        ],
      ),
    );
  }

  @override
  Future<String?> pickBackupFileContent() async {
    final result = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json'],
      withData: true,
    );
    if (result == null || result.files.isEmpty) {
      return null;
    }
    final picked = result.files.single;
    if (picked.bytes != null) {
      return utf8.decode(picked.bytes!);
    }
    if (picked.path != null) {
      return await File(picked.path!).readAsString();
    }
    return null;
  }
}
