import 'package:shared_preferences/shared_preferences.dart';

class SimuladoQuotaDatasource {
  static const _keyDate = 'simulado_quota_date';
  static const _keyCount = 'simulado_quota_count';

  Future<int> simuladosIniciadosHoje() async {
    final prefs = await SharedPreferences.getInstance();
    final storedDate = prefs.getString(_keyDate);
    final today = _todayKey();
    if (storedDate != today) {
      return 0;
    }
    return prefs.getInt(_keyCount) ?? 0;
  }

  Future<void> registrarInicioSimuladoHoje() async {
    final prefs = await SharedPreferences.getInstance();
    final today = _todayKey();
    final storedDate = prefs.getString(_keyDate);
    var count = 0;
    if (storedDate == today) {
      count = prefs.getInt(_keyCount) ?? 0;
    }
    await prefs.setString(_keyDate, today);
    await prefs.setInt(_keyCount, count + 1);
  }

  String _todayKey() {
    final now = DateTime.now();
    return '${now.year}-${now.month}-${now.day}';
  }
}
