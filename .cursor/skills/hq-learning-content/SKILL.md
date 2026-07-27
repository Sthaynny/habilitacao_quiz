---
name: hq-learning-content
description: >-
  Audita e enriquece markdowns em assets/learning para prova CNH: menos genérico,
  mais embasamento (CTB, CONTRAN, MBST, PAS), seção Referências, contentVersion e
  CONTENT_CHANGELOG. Use ao pedir melhorar conteúdo Aprender, fichas ou temas.
---

# Conteúdo Aprender — enriquecimento e referências

## Quando usar

- Lotes de revisão em `assets/learning/**/*.md`
- Novos temas, fichas ou artigos offline
- Alinhar texto à prova teórica CNH sem implementar HQ-I*

## Documentação

- Spec: [area-aprendizado.md](../../docs/features/area-aprendizado.md)
- Changelog: [CONTENT_CHANGELOG.md](../../assets/learning/CONTENT_CHANGELOG.md)
- Manifest: [manifest.json](../../assets/learning/manifest.json)

## Fluxo

1. Ler `manifest.json` e listar paths de temas, fichas e trilhas.
2. Para cada `.md`: remover frases vagas; acrescentar tópicos que a prova cobra (por tema).
3. Estrutura: títulos claros, bullets, tabelas mnemônicas quando ajudam; fichas curtas, artigos mais profundos.
4. Final obrigatório — copiar padrão de `CONTENT_CHANGELOG.md` § Padrão de referências (v2).
5. Se o lote altera conteúdo pedagógico: incrementar `contentVersion`, atualizar `contentChangelog` no manifest e linha em `CONTENT_CHANGELOG.md`.
6. Alterar `trilha_*.json` só se IDs, ordem ou metadados mudarem.
7. Opcional T28: cruzar `explicacao` em `assets/json/*.json` com artigos (sem LLM).
8. Rodar `flutter test test/features/learning/` se mexer em models ou manifest parsing.
9. Commit só se o usuário pedir ([git-commit-protocol.md](../../docs/engineering/git-commit-protocol.md)).

## Regras de fonte

- Priorizar: Planalto (leis), CONTRAN/SENATRAN (MBST, resoluções), MS (SAMU/PAS), CONAMA/IBAMA, ABNT (pneus).
- Não inventar redação de artigo de lei; citar número ou pedir conferência de vigência.
- Valores de multa e consolidações: nota “conferir legislação vigente”.

## Proibido

- HQ-I*, coach IA, geração via API de modelo em runtime
- Dependências novas só para Markdown

## Delegação

Implementação de UI/repo: agente [feature-aprendizado](../../agents/feature-aprendizado.md). Este skill cobre **só conteúdo estático** em `assets/learning/`.
