import 'package:flutter_test/flutter_test.dart';
import 'package:habilitacao_quiz/app/shared/domain/services/pro_gate.dart';

void main() {
  group('StubProGate Free', () {
    final gate = StubProGate();

    test('limites de sessão e simulado', () {
      expect(gate.maxQuestoesPorSessaoTema, 15);
      expect(gate.maxQuestoesSimulado, 15);
      expect(gate.maxResultadosHistorico, 10);
      expect(gate.exibirPromoPlus, isTrue);
    });

    test('simulado diário', () {
      expect(gate.podeIniciarSimuladoHoje(0), isTrue);
      expect(gate.podeIniciarSimuladoHoje(1), isFalse);
    });

    test('histórico', () {
      expect(gate.podeSalvarResultado(9), isTrue);
      expect(gate.podeSalvarResultado(10), isFalse);
      expect(gate.podeVerDashboardMateriaHistorico, isFalse);
    });
  });

  group('StubProGate Pro', () {
    final gate = StubProGate(isPro: true);

    test('simulado 30q; temas fixos em 15 para estudo', () {
      expect(gate.maxQuestoesPorSessaoTema, 15);
      expect(gate.maxQuestoesSimulado, 30);
      expect(gate.maxResultadosHistorico, isNull);
      expect(gate.exibirPromoPlus, isFalse);
      expect(gate.podeIniciarSimuladoHoje(99), isTrue);
    });

    test('histórico ilimitado (T21 ≥15 saves)', () {
      expect(gate.podeSalvarResultado(14), isTrue);
      expect(gate.podeSalvarResultado(15), isTrue);
      expect(gate.podeSalvarResultado(100), isTrue);
      expect(gate.podeVerDashboardMateriaHistorico, isTrue);
    });
  });
}
