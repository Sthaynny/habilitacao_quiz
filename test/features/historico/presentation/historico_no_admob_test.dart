import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('historico feature has no AdMob residue (HQ-H11)', () {
    final historicoDir = Directory('lib/app/features/historico');
    expect(historicoDir.existsSync(), isTrue);

    const forbidden = [
      'google_mobile_ads',
      'BannerAd',
      'AdHelper',
      'bannerAdNotifier',
    ];

    final dartFiles = historicoDir
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
  });
}
