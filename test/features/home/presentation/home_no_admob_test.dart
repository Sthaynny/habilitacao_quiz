import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  const forbidden = [
    'google_mobile_ads',
    'BannerAd',
    'AdHelper',
    'bannerAdNotifier',
    'MobileAds',
    'bottomAd',
  ];

  void expectNoAdMobInDirectory(String relativePath, String label) {
    final dir = Directory(relativePath);
    expect(dir.existsSync(), isTrue, reason: '$label directory must exist');

    final dartFiles = dir
        .listSync(recursive: true)
        .whereType<File>()
        .where((f) => f.path.endsWith('.dart'));

    for (final file in dartFiles) {
      final content = file.readAsStringSync();
      for (final token in forbidden) {
        expect(
          content.contains(token),
          isFalse,
          reason: '${file.path} must not contain $token',
        );
      }
    }
  }

  test('home feature has no AdMob residue (PROMO)', () {
    expectNoAdMobInDirectory('lib/app/features/home', 'home');
  });

  test('promo feature has no AdMob residue (PROMO)', () {
    expectNoAdMobInDirectory('lib/app/features/promo', 'promo');
  });

  test('main.dart has no AdMob residue (PROMO)', () {
    final mainFile = File('lib/main.dart');
    expect(mainFile.existsSync(), isTrue);

    final content = mainFile.readAsStringSync();
    for (final token in forbidden) {
      expect(
        content.contains(token),
        isFalse,
        reason: 'lib/main.dart must not contain $token',
      );
    }
  });
}
