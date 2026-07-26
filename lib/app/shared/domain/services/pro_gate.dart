import 'package:habilitacao_quiz/core/edition/app_edition.dart';

abstract interface class ProGate {
  bool get isPro;

  bool get exibirPromoPlus;

  /// `null` = sem limite (banco completo).
  int? get maxQuestoesPorSessaoTema;

  int get maxQuestoesSimulado;

  /// `null` = ilimitado.
  int? get maxSimuladosPorDia;

  /// `null` = histórico ilimitado.
  int? get maxResultadosHistorico;

  bool podeIniciarSimuladoHoje(int simuladosHoje);

  bool podeSalvarResultado(int quantidadeAtual);

  /// Dashboard % por matéria na aba Histórico (Pro).
  bool get podeVerDashboardMateriaHistorico;
}

final class CompileTimeProGate implements ProGate {
  const CompileTimeProGate();

  @override
  bool get isPro => kIsPro;

  @override
  bool get exibirPromoPlus => !kIsPro;

  @override
  int? get maxQuestoesPorSessaoTema => kIsPro ? null : 15;

  @override
  int get maxQuestoesSimulado => kIsPro ? 30 : 15;

  @override
  int? get maxSimuladosPorDia => kIsPro ? null : 1;

  @override
  int? get maxResultadosHistorico => kIsPro ? null : 10;

  @override
  bool podeIniciarSimuladoHoje(int simuladosHoje) {
    final max = maxSimuladosPorDia;
    if (max == null) return true;
    return simuladosHoje < max;
  }

  @override
  bool podeSalvarResultado(int quantidadeAtual) {
    final max = maxResultadosHistorico;
    if (max == null) return true;
    return quantidadeAtual < max;
  }

  @override
  bool get podeVerDashboardMateriaHistorico => kIsPro;
}

/// Gate configurável para testes.
final class StubProGate implements ProGate {
  StubProGate({
    this.isPro = false,
    this.maxQuestoesPorSessaoTemaFree = 15,
    this.maxQuestoesSimuladoFree = 15,
    this.maxQuestoesSimuladoPro = 30,
    this.maxSimuladosPorDiaFree = 1,
    this.maxResultadosHistoricoFree = 10,
  });

  @override
  final bool isPro;

  final int maxQuestoesPorSessaoTemaFree;
  final int maxQuestoesSimuladoFree;
  final int maxQuestoesSimuladoPro;
  final int maxSimuladosPorDiaFree;
  final int maxResultadosHistoricoFree;

  @override
  bool get exibirPromoPlus => !isPro;

  @override
  int? get maxQuestoesPorSessaoTema => isPro ? null : maxQuestoesPorSessaoTemaFree;

  @override
  int get maxQuestoesSimulado => isPro ? maxQuestoesSimuladoPro : maxQuestoesSimuladoFree;

  @override
  int? get maxSimuladosPorDia => isPro ? null : maxSimuladosPorDiaFree;

  @override
  int? get maxResultadosHistorico => isPro ? null : maxResultadosHistoricoFree;

  @override
  bool podeIniciarSimuladoHoje(int simuladosHoje) {
    final max = maxSimuladosPorDia;
    if (max == null) return true;
    return simuladosHoje < max;
  }

  @override
  bool podeSalvarResultado(int quantidadeAtual) {
    final max = maxResultadosHistorico;
    if (max == null) return true;
    return quantidadeAtual < max;
  }

  @override
  bool get podeVerDashboardMateriaHistorico => isPro;
}
