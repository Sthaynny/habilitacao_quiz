# Prioridades

**Regra:** código e produto primeiro · publicação **+** quando Onda 1 estiver estável.

**Atualizado:** 30 jul 2026 — Free retenção (F01–F04) e T28b concluídos; foco em conteúdo T28c, a11y e loja.

## Agora (P0) — Conteúdo e polish funcional

| Ordem | ID | Tarefa | Agente |
| :---: | :--- | :--- | :--- |
| 1 | T28c | `explicacao` nos demais JSON | `feature-conteudo-questoes` |
| 2 | A11Y-HIST + A11Y-LEARN | Lista histórico + hub Aprender | `feature-a11y-implementer` |
| 3 | A11Y-GATE | Fechar checklist (questionário) | `feature-a11y-implementer` |

## Em seguida (P1) — Loja

| Ordem | ID | Tarefa | Agente |
| :---: | :--- | :--- | :--- |
| 1 | T15 | Smoke manual + AAB | `feature-store-publish` |
| 2 | T16–T18 | Ficha Play **+** + `isProPublished` | `feature-store-publish` |
| 3 | T01 | Aprovar matriz Free/Pro e preço **+** | `hq-orchestrator` |
| 4 | T19–T20 | Data safety + TestFlight iOS | `feature-store-publish` |

## Depois (P2)

| ID | Tarefa | Agente |
| :--- | :--- | :--- |
| T28d | `referencia_ctb` em legislação e dir. defensiva | `feature-conteudo-questoes` |

## Concluído (referência)

Ondas 1–3, F01–F04, T28a–b — ver [FINALIZADAS.md](../tasks/FINALIZADAS.md).

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
