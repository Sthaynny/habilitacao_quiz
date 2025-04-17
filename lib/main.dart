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
  // Configurar o ID do dispositivo de teste
  MobileAds.instance.updateRequestConfiguration(
    RequestConfiguration(
      testDeviceIds: ['YOUR_DEVICE_ID'], // Coloque aqui o ID do seu emulador
    ),
  );

  return MobileAds.instance.initialize();
}
