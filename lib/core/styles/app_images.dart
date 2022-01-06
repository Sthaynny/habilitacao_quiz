abstract class AppImages {
  static String _getImage(String value) => "assets/imagens/$value.png";
  static String get legislacao => _getImage("legislacao");
  static String get primeirosSocorros => _getImage("primeiros_socorros");
  static String get mecanica => _getImage("mecanica");
  static String get meioAmbiente => _getImage("meio_ambiente");
  static String get aleatoria => _getImage("aleatoria");
  static String get logo => _getImage("carro");
}
