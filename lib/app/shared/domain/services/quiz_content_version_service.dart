import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:habilitacao_quiz/app/shared/data/datasources/quiz_content_version_datasource.dart';

/// F04 — detecta bump de `bundleVersion` em [content_manifest.json].
class QuizContentVersionService {
  QuizContentVersionService(this._datasource);

  static const assetPath = 'assets/json/content_manifest.json';

  final QuizContentVersionDatasource _datasource;

  Future<int> lerBundleVersionAtual() async {
    final raw = await rootBundle.loadString(assetPath);
    final map = jsonDecode(raw) as Map<String, dynamic>;
    return map['bundleVersion'] as int? ?? 0;
  }

  /// Retorna `true` se o bundle foi atualizado desde a última sessão.
  Future<bool> detectarAtualizacaoConteudo() async {
    final atual = await lerBundleVersionAtual();
    final vista = await _datasource.lerVersaoVista();

    if (vista == null) {
      await _datasource.salvarVersaoVista(atual);
      return false;
    }

    if (atual > vista) {
      await _datasource.salvarVersaoVista(atual);
      return true;
    }

    return false;
  }
}
