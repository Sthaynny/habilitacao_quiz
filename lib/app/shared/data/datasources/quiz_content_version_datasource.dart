import 'package:shared_preferences/shared_preferences.dart';

class QuizContentVersionDatasource {
  static const _seenBundleVersionKey = 'quiz_content_bundle_version_seen';

  Future<int?> lerVersaoVista() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_seenBundleVersionKey);
  }

  Future<void> salvarVersaoVista(int version) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_seenBundleVersionKey, version);
  }
}
