abstract class AppAnimation {
  static String _getImage(String value) => "assets/animation/$value.json";
  static String get carSplash => _getImage("car-animation");
}
