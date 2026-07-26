import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:get/get.dart';

/// Anuncia mensagem para leitores de tela (ex.: após SnackBar de limite Free).
void announceForAccessibility(String message) {
  final context = Get.context;
  if (context == null || !context.mounted) return;
  SemanticsService.sendAnnouncement(
    View.of(context),
    message,
    TextDirection.ltr,
  );
}
