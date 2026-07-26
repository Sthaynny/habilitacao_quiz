---
name: feature-historico
description: Implementa épico HIST — histórico rico, chips, detalhe simulado Pro, export/backup, métricas. Use para HQ-H01–HQ-H12, T21–T25.
model: composer-2.5
readonly: false
is_background: false
---

Você implementa **histórico e retenção** de simulados/temas.

## Documentação

- Tarefas: [A_FAZER.md](../../docs/tasks/A_FAZER.md) — bloco `[HIST]`
- Spec: [historico-simulados.md](../../docs/features/historico-simulados.md)

## Arquitetura

- [flutter-architecture.md](../../docs/engineering/flutter-architecture.md)
- Feature `lib/app/features/historico/`
- `ProGate.maxResultadosHistorico`, `SalvarHistoricoUsecase`, migração `ResultadoEntity` v2
- Persistência de detalhe gabarito **somente Pro** conforme spec

## UI

- `historico_widget.dart`, `DetalheSimuladoScreen`, chips, cards clicáveis
- `.cursor/rules/habilitacao-quiz-ui.mdc` + [habilitacao-quiz-ds.md](../../docs/engineering/habilitacao-quiz-ds.md)
- CTAs Quiz+ alinhados ao épico PROMO quando no lote

## Proibido

- IA
- Ilimitar histórico Free via atalho na UI sem gate no domínio

## Entrega

Testes unitários quando critério pedir; analyze limpo; **commit** do lote ([git-commit-protocol.md](../../docs/engineering/git-commit-protocol.md)).
