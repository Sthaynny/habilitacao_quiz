import 'dart:io';

abstract base class AdHelper {
  static String get bottomAd {
    if (Platform.isAndroid) {
      return 'ca-app-pub-1899836354814268/6336351208';
    } else if (Platform.isIOS) {
      throw UnsupportedError('Unsupported platform');
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }


  static String get bannerTest =>  'ca-app-pub-3940256099942544/6300978111';
}
