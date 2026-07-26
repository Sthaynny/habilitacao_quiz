import 'dart:io';

import 'package:path_provider/path_provider.dart';

class HistoricoExportDatasource {
  Future<String> writeTempFile({
    required String filename,
    required List<int> bytes,
  }) async {
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/$filename');
    await file.writeAsBytes(bytes, flush: true);
    return file.path;
  }
}
