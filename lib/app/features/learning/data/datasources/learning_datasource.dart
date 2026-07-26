import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LearningDatasource {
  static const _assetPrefix = 'assets/learning/';
  static const _revisaoEspacadaKey = 'learning_revisao_espacada_ids';

  Future<String> loadManifestJson() async {
    return rootBundle.loadString('${_assetPrefix}manifest.json');
  }

  Future<String> loadAssetJson(String relativePath) async {
    return rootBundle.loadString('$_assetPrefix$relativePath');
  }

  Future<String> loadMarkdown(String relativePath) async {
    return rootBundle.loadString('$_assetPrefix$relativePath');
  }

  String _progressKey(String trilhaId) => 'learning_trilha_progress_$trilhaId';

  Future<Set<String>> loadTrilhaProgresso(String trilhaId) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_progressKey(trilhaId));
    if (raw == null || raw.isEmpty) return {};
    final list = jsonDecode(raw) as List<dynamic>;
    return list.map((e) => e.toString()).toSet();
  }

  Future<void> salvarPassoTrilha({
    required String trilhaId,
    required String stepId,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final progresso = await loadTrilhaProgresso(trilhaId);
    progresso.add(stepId);
    await prefs.setString(
      _progressKey(trilhaId),
      jsonEncode(progresso.toList()),
    );
  }

  Future<List<String>> loadRevisaoEspacadaIds() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_revisaoEspacadaKey);
    if (raw == null || raw.isEmpty) return [];
    final list = jsonDecode(raw) as List<dynamic>;
    return list.map((e) => e.toString()).toList();
  }

  Future<void> saveRevisaoEspacadaIds(List<String> ids) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_revisaoEspacadaKey, jsonEncode(ids));
  }
}
