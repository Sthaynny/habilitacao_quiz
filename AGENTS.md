# Agentes — Habilitação Quiz

Orquestração de implementação do roadmap ([PRODUCT_PLAN](docs/product/PRODUCT_PLAN.md), [A_FAZER](docs/tasks/A_FAZER.md)) com subagentes **Composer** (`composer-2.5`). **IA (Onda 4 / `[IA]`) fica fora de escopo** até haver receita por compras do **+**.

## Papéis

| Agente | Skill | Modelo | Git commit |
| :--- | :--- | :--- | :--- |
| **Orquestrador** (agente principal neste chat) | [hq-orchestrator](.cursor/skills/hq-orchestrator/SKILL.md) | padrão do chat | **Sim** — único responsável por `git add` / `git commit` |
| Implementador por épico | [hq-feature-worker](.cursor/skills/hq-feature-worker/SKILL.md) | `composer-2.5` | **Não** |
| Crítico de produto | [hq-feature-critic](.cursor/skills/hq-feature-critic/SKILL.md) | `composer-2.5` | **Não** |
| Analista de acessibilidade | [hq-a11y-analyst](.cursor/skills/hq-a11y-analyst/SKILL.md) | `composer-2.5` | **Não** |

## Épicos (um worker por vez)

| Épico | IDs | Doc |
| :--- | :--- | :--- |
| `[GATE]` + `[STORE]` | T02–T09, T15–T20 | [modelo-free-pro](docs/features/modelo-free-pro.md) |
| `[PROMO]` | HQ-P01–HQ-P13, T31 | [promocao-quiz-plus](docs/features/promocao-quiz-plus.md) |
| `[HIST]` | HQ-H01–HQ-H12, T21–T25 | [historico-simulados](docs/features/historico-simulados.md) |
| `[LEARN]` | HQ-A01–HQ-A15, T26–T28 | [area-aprendizado](docs/features/area-aprendizado.md) |
| ~~`[IA]`~~ | HQ-I* | **Não executar** — ver [AI_FEATURES](docs/product/AI_FEATURES.md) |

Ordem sugerida: ver bloco “Ordem sugerida” em [A_FAZER.md](docs/tasks/A_FAZER.md).

## Como disparar (orquestrador)

1. Escolher o próximo lote de tarefas (1 épico ou fatia pequena dentro dele).
2. `Task` → `subagent_type: generalPurpose`, **`model: composer-2.5`**, prompt do worker com IDs e critérios de pronto.
3. Em paralelo ou após o diff: critic + a11y nos arquivos `lib/**` tocados.
4. Rodar `flutter analyze` e testes afetados; corrigir depreciações/lint.
5. Consolidar feedback; subagentes **não** commitam.
6. **Orquestrador** commita (mensagem focada no “porquê”, um épico ou tarefa por commit quando possível).

## Qualidade Flutter

Regra permanente: [.cursor/rules/flutter-agent-standards.mdc](.cursor/rules/flutter-agent-standards.mdc).

UI: skill [ui-design-system-code](.cursor/skills/ui-design-system-code/SKILL.md) e [habilitacao-quiz-ds](.cursor/skills/ui-design-system-code/references/habilitacao-quiz-ds.md).

## Frase de ativação

> “Orquestrar épico `[PROMO]`” / “Implementar T02–T03 com subagentes” / “Rodar crítico + a11y no último diff”
