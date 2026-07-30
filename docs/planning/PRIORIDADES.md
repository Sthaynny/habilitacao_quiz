# Prioridades

**Regra:** código e produto primeiro · publicação **+** quando Onda 1 estiver estável.

**Atualizado:** 30 jul 2026 — Ondas 1–3 **implementadas** no código; foco em loja, conteúdo e a11y.

## Agora (P0) — Publicar e validar

| Ordem | ID | Tarefa | Agente |
| :---: | :--- | :--- | :--- |
| 1 | T01 | Aprovar matriz Free/Pro e preço **+** | `hq-orchestrator` |
| 2 | T15 | Smoke AAB Free + Pro | `feature-store-publish` |
| 3 | T16–T18 | Ficha Play **+** + `isProPublished` | `feature-store-publish` |
| 4 | A11Y-GATE | TalkBack nos limites Free | `feature-a11y-implementer` |

## Em seguida (P1) — Conteúdo e polish

| ID | Tarefa | Agente |
| :--- | :--- | :--- |
| T28b–d | Explicações + referências CTB | `feature-conteudo-questoes` |
| A11Y-HIST + A11Y-LEARN | Lista histórico + hub Aprender | `feature-a11y-implementer` |
| T19–T20 | Data safety + TestFlight iOS | `feature-store-publish` |

## Depois (P2) — Retenção Free

| Bloco | Tarefas | Agente |
| :--- | :--- | :--- |
| Free evolution | F01–F04 | `feature-free-evolution` |

## Futuro (P3) — IA

| Bloco | Tarefas | Agente |
| :--- | :--- | :--- |
| Conteúdo + proxy | HQ-I01–I10 | `feature-ia-pro` (readonly até receita) |
| Coach | HQ-I11–I14 | `feature-ia-pro` |

## Concluído (referência)

Ondas 1–3: T02–T09, HQ-P*, HQ-H*, HQ-A*, T21–T27 — ver [FINALIZADAS.md](../tasks/FINALIZADAS.md).

## O que não fazer ainda

- Chat livre CNH (IA)
- IAP in-app no Free
- Sync nuvem / login
- i18n EN (até tração BR)

## Como a IA deve usar este arquivo

1. Pegar a **primeira** tarefa P0 não feita em [A_FAZER.md](../tasks/A_FAZER.md).
2. Disparar o **subagente** indicado na coluna Agente.
3. Respeitar **critério de pronto** antes de marcar feito.
4. Mover para `FINALIZADAS.md` e atualizar roadmap se necessário.
