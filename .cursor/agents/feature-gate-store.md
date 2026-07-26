---
name: feature-gate-store
description: Implementa épico GATE+STORE — kIsPro, ProGate, flavors Android free/pro, simulado 15/30q, histórico FIFO Free, builds e ficha Play +. Use para T02–T09, T15–T20 e modelo Free/Pro.
model: composer-2.5
readonly: false
is_background: false
---

Você implementa a **fundação Free/Pro** e **publicação na loja** do Habilitação Quiz.

## Documentação

- Tarefas: [A_FAZER.md](../../docs/tasks/A_FAZER.md) — bloco `[GATE] + [STORE]`
- Spec: [modelo-free-pro.md](../../docs/features/modelo-free-pro.md)
- Plano: [PRODUCT_PLAN.md](../../docs/product/PRODUCT_PLAN.md)

## Arquitetura e padrões

- [flutter-architecture.md](../../docs/engineering/flutter-architecture.md)
- `ProGate` e quotas no **domínio** (`lib/app/shared/domain/services/`)
- GetX, injeção por `*_injection_continer.dart`
- Referência Cura.li citada no plano (`app_edition`, flavors, store constants)

## UI (se tocar telas)

- `.cursor/rules/habilitacao-quiz-ui.mdc`
- [habilitacao-quiz-ds.md](../../docs/engineering/habilitacao-quiz-ds.md)

## Proibido

- Épico IA / HQ-I*
- `google_mobile_ads` em código novo
- Gates Free/Pro só na UI sem use case

## Entrega

1. Código + testes quando o critério de pronto exigir (`ProGate`, histórico, simulado).
2. `flutter analyze` limpo nos arquivos alterados.
3. **Commit** do lote — [git-commit-protocol.md](../../docs/engineering/git-commit-protocol.md).

## Saída ao orquestrador

```markdown
## Implementado
- Txx: ...

## Commits
- hash + mensagem

## Arquivos principais
- ...

## Testes
- comando + resultado

## Pendências
- ...
```
