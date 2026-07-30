# Agentes — Habilitação Quiz

Orquestração do roadmap ([PRODUCT_PLAN](docs/product/PRODUCT_PLAN.md), [A_FAZER](docs/tasks/A_FAZER.md)) com **subagentes** definidos em [.cursor/agents/](.cursor/agents/). **IA (Onda 4 / `[IA]`) fica fora de escopo** até haver receita por compras do **+**.

## Papéis

| Agente | Arquivo | Modelo | Git commit |
| :--- | :--- | :--- | :--- |
| **Orquestrador** (chat principal) | [hq-orchestrator](.cursor/agents/hq-orchestrator.md) | inherit | Só docs/coordenação |
| **GATE + STORE** (código) | [feature-gate-store](.cursor/agents/feature-gate-store.md) | composer-2.5 | **Sim** |
| **Publicação loja** | [feature-store-publish](.cursor/agents/feature-store-publish.md) | composer-2.5 | Docs/constantes |
| **PROMO** | [feature-promo](.cursor/agents/feature-promo.md) | composer-2.5 | **Sim** |
| **HIST** | [feature-historico](.cursor/agents/feature-historico.md) | composer-2.5 | **Sim** |
| **LEARN** | [feature-aprendizado](.cursor/agents/feature-aprendizado.md) | composer-2.5 | **Sim** |
| **Conteúdo questões** | [feature-conteudo-questoes](.cursor/agents/feature-conteudo-questoes.md) | composer-2.5 | **Sim** — lote por JSON |
| **Retenção Free** | [feature-free-evolution](.cursor/agents/feature-free-evolution.md) | composer-2.5 | **Sim** |
| **IA (guardião)** | [feature-ia-pro](.cursor/agents/feature-ia-pro.md) | inherit | Não (readonly) |
| Crítico de produto | [product-critic](.cursor/agents/product-critic.md) | composer-2.5 | Não (readonly) |
| Acessibilidade (revisão) | [a11y-analyst](.cursor/agents/a11y-analyst.md) | composer-2.5 | Não (readonly) |
| Acessibilidade (implementação) | [feature-a11y-implementer](.cursor/agents/feature-a11y-implementer.md) | composer-2.5 | **Sim** — um commit por [doc feature](docs/features/acessibilidade-implementacao.md) |

## Épicos e documentação

| Épico | IDs | Doc feature | Agente |
| :--- | :--- | :--- | :--- |
| `[GATE]` + `[STORE]` código | T02–T09 | [modelo-free-pro](docs/features/modelo-free-pro.md) | `feature-gate-store` |
| `[STORE-PUB]` loja | T15–T20 | [store/README](docs/store/README.md) | `feature-store-publish` |
| `[PROMO]` | HQ-P01–HQ-P13, T31 | [promocao-quiz-plus](docs/features/promocao-quiz-plus.md) | `feature-promo` |
| `[HIST]` | HQ-H01–HQ-H12, T21–T25 | [historico-simulados](docs/features/historico-simulados.md) | `feature-historico` |
| `[LEARN]` | HQ-A01–HQ-A15, T26–T27 | [area-aprendizado](docs/features/area-aprendizado.md) | `feature-aprendizado` |
| `[CONTEUDO]` | T28a–d | [ia-pro](docs/features/ia-pro.md) §schema | `feature-conteudo-questoes` |
| `[A11Y]` | A11Y-* | [acessibilidade-implementacao](docs/features/acessibilidade-implementacao.md) | `feature-a11y-implementer` |
| `[FREE-RET]` | F01–F04 | [PRODUCT_PLAN](docs/product/PRODUCT_PLAN.md) §8.3 | `feature-free-evolution` |
| ~~`[IA]`~~ | HQ-I* | **Não executar** — [feature-ia-pro](.cursor/agents/feature-ia-pro.md) | readonly |

Ordem sugerida: bloco “Ordem sugerida” em [A_FAZER.md](docs/tasks/A_FAZER.md).

## Engenharia (padrões compartilhados)

- Arquitetura e design patterns: [flutter-architecture.md](docs/engineering/flutter-architecture.md)
- Design system: [habilitacao-quiz-ds.md](docs/engineering/habilitacao-quiz-ds.md)
- Commits dos implementadores: [git-commit-protocol.md](docs/engineering/git-commit-protocol.md)

## Como disparar

1. Orquestrador escolhe o lote (IDs + épico).
2. `Task` → subagente da feature (`subagent_type` conforme Cursor) ou invocar `/feature-promo` etc.
3. Após o diff: `product-critic` + `a11y-analyst` em paralelo; blockers de a11y → `feature-a11y-implementer` (commit por doc em [acessibilidade-implementacao.md](docs/features/acessibilidade-implementacao.md)).
4. Orquestrador roda `flutter analyze` e testes; integra blockers.
5. **Agente de feature** commita o código ([git-commit-protocol](docs/engineering/git-commit-protocol.md)).

## Qualidade Flutter

Regra: [.cursor/rules/flutter-agent-standards.mdc](.cursor/rules/flutter-agent-standards.mdc)  
UI: [.cursor/rules/habilitacao-quiz-ui.mdc](.cursor/rules/habilitacao-quiz-ui.mdc)

## Frases de ativação

> “Orquestrar épico `[STORE-PUB]`” / “`feature-store-publish` para T15” / “`feature-conteudo-questoes` para T28a” / “Rodar `product-critic` e `a11y-analyst` no último diff” / “`feature-a11y-implementer` em [promocao-quiz-plus.md](docs/features/promocao-quiz-plus.md)”
