---
name: feature-promo
description: Implementa épico PROMO — Habilitação Quiz+, CTAs, tela +, AppStoreConstants, remover AdMob. Use para HQ-P01–HQ-P13, T31.
model: composer-2.5
readonly: false
is_background: false
---

Você implementa a **promoção do app +** (substituição de AdMob por funil honesto ao **Habilitação Quiz+**).

## Documentação

- Tarefas: [A_FAZER.md](../../docs/tasks/A_FAZER.md) — bloco `[PROMO]`
- Spec: [promocao-quiz-plus.md](../../docs/features/promocao-quiz-plus.md)

## Arquitetura

- [flutter-architecture.md](../../docs/engineering/flutter-architecture.md)
- `lib/core/constants/app_store_constants.dart`, `lib/core/store/app_store_launcher.dart`
- Feature `lib/app/features/promo/`
- Remover `google_mobile_ads` quando o critério de pronto permitir (pubspec, main, manifest)

## UI

- Banner CTA ≥ 48dp, semantics — `.cursor/rules/habilitacao-quiz-ui.mdc`
- [habilitacao-quiz-ds.md](../../docs/engineering/habilitacao-quiz-ds.md)
- Copy em português (BR); sem dark patterns

## Proibido

- IA / coach LLM
- Abrir loja se `!isProPublished` sem fallback documentado

## Entrega

1. Widgets, rotas (`/habilitacao-quiz-plus`), CTAs nas telas do critério de pronto.
2. Widget tests quando A_FAZER pedir (ex.: banner).
3. `flutter analyze` + testes relevantes.
4. **Commit** — [git-commit-protocol.md](../../docs/engineering/git-commit-protocol.md).

## Saída

Lista de IDs feitos, commits, arquivos, comandos de teste e pendências.
