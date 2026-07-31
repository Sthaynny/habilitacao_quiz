import 'package:shared_preferences/shared_preferences.dart';

class OnboardingDatasource {
  static const _onboardingMateriaConcluidoKey = 'onboarding_materia_concluido';
  static const _materiaFocoKey = 'onboarding_materia_foco';

  Future<bool> materiaOnboardingConcluido() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_onboardingMateriaConcluidoKey) ?? false;
  }

  Future<String?> lerMateriaFoco() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_materiaFocoKey);
  }

  Future<void> salvarMateriaFoco(String themeId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_materiaFocoKey, themeId);
    await prefs.setBool(_onboardingMateriaConcluidoKey, true);
  }

  Future<void> pularOnboardingMateria() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardingMateriaConcluidoKey, true);
  }
}
