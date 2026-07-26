import 'package:flutter/foundation.dart';

/// Superfície onde o funil **+** é exibido ou acionado.
enum PromoSurface {
  homeBanner,
  historicoFooter,
  resultadoSimulado,
  plusScreen,
  legalTile,
  gateSimuladoDiario,
  gateHistoricoLimite,
}

enum PromoClickTarget {
  openPlusScreen,
  openStore,
}

/// Eventos de impressão/clique do funil promo (Firebase opcional no futuro).
abstract interface class PromoFunnelAnalytics {
  void logImpression(PromoSurface surface);

  void logClick(PromoSurface surface, PromoClickTarget target);
}

/// Implementação padrão: log em debug; no-op em release até integrar Firebase.
final class DebugPromoFunnelAnalytics implements PromoFunnelAnalytics {
  const DebugPromoFunnelAnalytics();

  @override
  void logClick(PromoSurface surface, PromoClickTarget target) {
    if (kDebugMode) {
      debugPrint('[promo] click ${surface.name} → ${target.name}');
    }
  }

  @override
  void logImpression(PromoSurface surface) {
    if (kDebugMode) {
      debugPrint('[promo] impression ${surface.name}');
    }
  }
}
