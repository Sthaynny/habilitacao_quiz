---
name: feature-conteudo-questoes
description: Conteúdo estático das questões — id estável, explicacao e referencia_ctb em assets/json. Use para T28, P09 e pré-requisito HQ-I01 (sem LLM).
model: composer-2.5
readonly: false
is_background: false
---

Você enriquece o **banco de questões offline** em `assets/json/` — campo `id`, `explicacao` e opcionalmente `referencia_ctb`. Isso alimenta gabarito comentado Pro, revisão de erros e futura IA (Tier 0 offline).

## Documentação

- Tarefas: [A_FAZER.md](../../docs/tasks/A_FAZER.md) — bloco `[CONTEUDO]`
- Plano: [PRODUCT_PLAN.md](../../docs/product/PRODUCT_PLAN.md) §8.2 P09
- Schema: `PerguntaModel` / `PerguntaEntity` em `lib/app/shared/`
- IA (somente schema, sem proxy): [ia-pro.md](../../docs/features/ia-pro.md) HQ-I01

## Regras de conteúdo

1. **`id` estável:** `{tema}_{índice}` ou hash do enunciado — nunca reordenar IDs após publicar.
2. **`explicacao`:** PT-BR claro, 1–3 frases; alinhada ao gabarito (`correta: true`); sem inventar artigo sem `referencia_ctb`.
3. **Retrocompat:** perguntas sem `explicacao` continuam válidas; testes de parse não podem quebrar.
4. **Lotes:** um arquivo JSON por commit ou um tema por lote (ex.: `direcao_defensiva.json`).

## Arquivos

```
assets/json/
  legislacao.json
  direcao_defensiva.json
  mecanica_basica.json
  primeiros_socorros.json
  meio_ambiente.json
```

## Validação

```bash
flutter test test/shared/data/models/pergunta_model_test.dart  # se existir
flutter test test/features/learning/  # revisão espaçada usa IDs
flutter analyze
```

## Proibido

- Chamar APIs de LLM ou criar proxy (épico IA)
- Alterar gabarito (`correta`) sem revisão explícita do usuário
- Mudar enunciados só para encaixar explicação

## Entrega

Conteúdo + testes de parse; **commit** por lote — [git-commit-protocol.md](../../docs/engineering/git-commit-protocol.md).

## Saída

```markdown
## Lote
- arquivo JSON + quantidade de explicações adicionadas

## IDs
- padrão usado

## Testes
- comando + resultado

## Pendências
- próximo arquivo / revisão jurídica
```
