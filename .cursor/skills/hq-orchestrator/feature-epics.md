# Prompts base — workers por épico

Copiar no `Task` prompt e substituir `{{IDS}}`.

## Template comum (todos os workers)

```text
Repositório: Habilitação Quiz (Flutter, Clean Architecture + GetX).
Tarefas: {{IDS}}
Leia critérios em docs/tasks/A_FAZER.md e a feature doc do épico.

Regras:
- NÃO implementar nada de IA (HQ-I*, AI_FEATURES).
- NÃO fazer git commit, push ou stash.
- Seguir .cursor/rules/flutter-agent-standards.mdc
- UI: .cursor/skills/ui-design-system-code/ (habilitacao-quiz-ds.md)
- Referência comercial: docs/product/PRODUCT_PLAN.md seção 7

Entrega:
1. Código + testes unitários quando o critério de pronto pedir
2. Lista de arquivos alterados
3. Riscos / follow-ups para o orquestrador
4. Comandos que o orquestrador deve rodar (analyze, test paths)
```

## `[GATE]` + `[STORE]`

```text
{{TEMPLATE}}
Épico: fundação Free/Pro — kIsPro, ProGate, flavors, use cases, simulado 15/30, histórico FIFO Free.
Doc: docs/features/modelo-free-pro.md
Pistas: cura.li app_edition, pro_gate, android flavors.
```

## `[PROMO]`

```text
{{TEMPLATE}}
Épico: substituir AdMob por promo Habilitação Quiz+ — constants, banner, tela +, rotas, CTAs.
Doc: docs/features/promocao-quiz-plus.md
Remover google_mobile_ads quando código morto sumir.
```

## `[HIST]`

```text
{{TEMPLATE}}
Épico: histórico rico, Pro ilimitado, chips, detalhe simulado Pro, export/backup se no lote.
Doc: docs/features/historico-simulados.md
Respeitar ProGate no domínio, não só UI.
```

## `[LEARN]`

```text
{{TEMPLATE}}
Épico: área Aprender — assets, hub, Markdown, aba, gates Pro.
Doc: docs/features/area-aprendizado.md
T26–T28 (revisão erros, modo prova, explicações JSON) são Pro sem LLM.
```
