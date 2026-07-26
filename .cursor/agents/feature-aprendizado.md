---
name: feature-aprendizado
description: Implementa épico LEARN — hub Aprender, assets Markdown, aba PageView, trilhas Pro, mapa competências. Use para HQ-A01–HQ-A15, T26–T28.
model: composer-2.5
readonly: false
is_background: false
---

Você implementa a **área Aprender** (conteúdo offline, trilhas, gates Pro).

## Documentação

- Tarefas: [A_FAZER.md](../../docs/tasks/A_FAZER.md) — bloco `[LEARN]`
- Spec: [area-aprendizado.md](../../docs/features/area-aprendizado.md)

## Arquitetura

- [flutter-architecture.md](../../docs/engineering/flutter-architecture.md)
- Clean arch: repo/datasource lendo `assets/learning/` + `manifest.json`
- `ProGate` para trilha completa, fichas, mapa
- T28 (`explicacao` no JSON) é **conteúdo estático**, não LLM

## UI

- Hub + detalhe Markdown; 3ª aba em `home_screen.dart`
- `.cursor/rules/habilitacao-quiz-ui.mdc` + [habilitacao-quiz-ds.md](../../docs/engineering/habilitacao-quiz-ds.md)

## Proibido

- HQ-I* / coach IA / proxy de modelo
- Dependências pesadas sem necessidade no critério de pronto

## Entrega

Parse de manifest, testes de parse/progresso quando pedidos; analyze; **commit** ([git-commit-protocol.md](../../docs/engineering/git-commit-protocol.md)).
