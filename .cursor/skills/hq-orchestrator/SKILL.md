---
name: hq-orchestrator
description: >-
  Orquestra subagentes Composer para implementar épicos do Habilitação Quiz
  (GATE, PROMO, HIST, LEARN), consolida crítica de produto e acessibilidade,
  valida Flutter analyze e é o único que faz git commit. Use quando o usuário
  pedir orquestração, roadmap, A_FAZER, subagentes por feature ou commits
  após implementação. Nunca incluir épico IA até receita do app pago.
---

# Orquestrador — Habilitação Quiz

Você é o **agente principal**. Subagentes implementam e revisam; **só você commita**.

## Escopo

- **Incluir:** T02–T20, HQ-P*, HQ-H*, HQ-A*, T21–T28 conforme [A_FAZER.md](../../../docs/tasks/A_FAZER.md).
- **Excluir:** toda seção `[IA]` / HQ-I* / [ia-pro.md](../../../docs/features/ia-pro.md) e [AI_FEATURES.md](../../../docs/product/AI_FEATURES.md) — parar se o lote misturar IA.

## Modelo dos subagentes

Todo `Task` para worker, crítico ou a11y:

```text
model: composer-2.5
subagent_type: generalPurpose
run_in_background: false   # salvo pedido explícito do usuário
```

## Fluxo por lote

1. **Planejar** — Listar IDs, doc em `docs/features/`, critério de pronto de cada tarefa.
2. **Worker** — Um subagente por épico ou fatia ≤ ~5 tarefas acopladas. Prompt: copiar template em [feature-epics.md](feature-epics.md) + IDs concretos.
3. **Crítico** — Subagente [hq-feature-critic](../hq-feature-critic/SKILL.md) sobre o diff (ou arquivos listados pelo worker).
4. **A11y** — Subagente [hq-a11y-analyst](../hq-a11y-analyst/SKILL.md) em `lib/**/*.dart` alterados com UI.
5. **Validar** (você executa no shell):
   - `flutter pub get`
   - `flutter analyze`
   - `flutter test` nos pacotes/pastas tocados
6. **Integrar** — Aplicar correções de lint/depreciação; revalidar se necessário.
7. **Commit** — Somente após analyze limpo (ou apenas infos aceitas no projeto). Seguir regra do usuário de commit (HEREDOC, sem `git add .` cego — preferir arquivos do lote).
8. **Backlog** — Mover tarefas concluídas para [FINALIZADAS.md](../../../docs/tasks/FINALIZADAS.md) quando o usuário pedir ou ao fechar o lote.

## Commits

- Um commit por fatia lógica (ex.: “ProGate + testes”, “remover AdMob + CTA home”).
- Mensagem em português ou inglês conforme histórico do `git log`.
- Subagentes **nunca** rodam `git commit`, `git push` ou alteram `git config`.

## Paralelismo

- Worker de épico A + worker de épico B **só** se não tocarem os mesmos arquivos (ex.: docs vs código).
- Crítico e a11y podem rodar em paralelo após o worker.

## Referências

- [AGENTS.md](../../../AGENTS.md)
- [PRODUCT_PLAN.md](../../../docs/product/PRODUCT_PLAN.md)
- Padrão Cura.li citado no plano (app edition, ProGate, store constants)
