import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:habilitacao_quiz/app/my_app.dart';
import 'package:habilitacao_quiz/global_injection_container.dart';

void main() {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await _initGoogleMobileAds();
      GlobalInjectionContainer.setInjection();
      runApp(const MyApp());
    },
    (error, stack) => debugPrint(error.toString()),
  );
}

Future<InitializationStatus> _initGoogleMobileAds() {
  return MobileAds.instance.initialize();
}
