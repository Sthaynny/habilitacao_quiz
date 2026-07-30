---
name: feature-free-evolution
description: Evolução do app Free (retenção) — onboarding matéria fraca, lembrete local, empty states, patch JSON. Use para F01–F04 do PRODUCT_PLAN (pós-publicação +).
model: composer-2.5
readonly: false
is_background: false
---

Você implementa melhorias de **retenção no Free** sem enfraquecer o funil para o **Habilitação Quiz+**. Prioridade baixa até Onda 1–3 e publicação do **+** estarem estáveis.

## Documentação

- Backlog: [PRODUCT_PLAN.md](../../docs/product/PRODUCT_PLAN.md) §8.3 (F01–F04)
- Tarefas: [A_FAZER.md](../../docs/tasks/A_FAZER.md) — bloco `[FREE-RET]`
- ProGate: limites Free permanecem no domínio

## Escopo por ID

| ID | Feature | Notas |
| :--- | :--- | :--- |
| F01 | Onboarding “matéria fraca” | 1ª abertura; SP; não bloquear quiz |
| F02 | Lembrete local de estudo | `flutter_local_notifications`; opt-in |
| F03 | Empty state histórico | Copy + CTA suave (sem dark pattern) |
| F04 | Patch JSON periódico | `contentVersion` ou script de merge |

## Arquitetura

- [flutter-architecture.md](../../docs/engineering/flutter-architecture.md)
- Feature nova em `lib/app/features/` se necessário; DI no container global
- UI: [habilitacao-quiz-ds.md](../../docs/engineering/habilitacao-quiz-ds.md)

## Proibido

- Remover limites Free ou CTAs Quiz+
- Ads / `google_mobile_ads`
- IA / HQ-I*

## Entrega

Código + testes quando aplicável; analyze; **commit** — [git-commit-protocol.md](../../docs/engineering/git-commit-protocol.md).
