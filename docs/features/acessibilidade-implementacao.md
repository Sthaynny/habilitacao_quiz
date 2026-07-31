# Acessibilidade — implementação por feature

Rastreio de **código acessível** alinhado a cada spec em `docs/features/`. Análise readonly: agente `a11y-analyst`. **Implementação:** agente `feature-a11y-implementer` (`.cursor/agents/feature-a11y-implementer.md`).

## Política de commit

| Regra | Detalhe |
| :--- | :--- |
| Granularidade | **Um commit Git por doc** desta pasta (épico), salvo correção de blocker pós-revisão no mesmo épico |
| Prefixo | `a11y(gate):`, `a11y(promo):`, `a11y(hist):`, `a11y(learn):` |
| Escopo do `git add` | Só `lib/**` (e testes) daquele épico — ver tabela abaixo |
| IA | `ia-pro.md` — sem commits de implementação até receita do **+** |

Protocolo completo: [git-commit-protocol.md](../engineering/git-commit-protocol.md).

## Mapa para o implementador

| Doc | Épico | Escopo típico em `lib/` | Agente de feature (funcional) |
| :--- | :--- | :--- | :--- |
| [modelo-free-pro.md](./modelo-free-pro.md) | GATE, STORE | `app/shared/`, `questionario/`, `resultado/`, flavors se UI de limite | `feature-gate-store` |
| [promocao-quiz-plus.md](./promocao-quiz-plus.md) | PROMO | `features/promo/`, CTAs em `home/`, `historico/`, `resultado/` | `feature-promo` |
| [historico-simulados.md](./historico-simulados.md) | HIST | `features/historico/presentation/` | `feature-historico` |
| [area-aprendizado.md](./area-aprendizado.md) | LEARN | `features/aprender/` (quando existir), bottom nav | `feature-aprendizado` |
| [ia-pro.md](./ia-pro.md) | IA | — | `feature-ia-pro` (somente leitura) |

## Ordem sugerida

1. **PROMO** + **GATE** — CTAs e limites são o que mais impacta TalkBack hoje.  
2. **HIST** — lista densa, chips, detalhe.  
3. **LEARN** — hub e leitura longa (Markdown, headings).  

Sincronizar com [A_FAZER.md](../tasks/A_FAZER.md) quando a feature ainda não existir no código: implementar a11y no mesmo lote do agente `feature-*` ou voltar com `feature-a11y-implementer` após o merge funcional.

## Status por doc (implementação)

| Doc | ID | Data | Commit sugerido |
| :--- | :--- | :--- | :--- |
| [promocao-quiz-plus.md](./promocao-quiz-plus.md) | A11Y-PROMO | 2026-07-30 | `a11y(promo): semantics e 48dp nos CTAs Quiz+` |
| [modelo-free-pro.md](./modelo-free-pro.md) | A11Y-GATE | 2026-07-30 | `a11y(gate): semantics nos snackbars de limite` (parcial) |
| [historico-simulados.md](./historico-simulados.md) | A11Y-HIST | — | pendente |
| [area-aprendizado.md](./area-aprendizado.md) | A11Y-LEARN | — | pendente |

## Critérios de pronto (por doc)

- [ ] Ícones e banners com `Semantics` ou equivalente em componente compartilhado  
- [ ] Alvos de toque ≥ 48dp em ações principais  
- [ ] Texto secundário via tokens (`AppColors.grey`), contraste AA sobre fundo branco  
- [ ] Sem overflow grosseiro com fonte 200%  
- [ ] `flutter analyze` limpo nos arquivos tocados  
- [ ] Revisão `a11y-analyst` sem **blocker**

## Como disparar

> “`feature-a11y-implementer` no doc [promocao-quiz-plus.md](./promocao-quiz-plus.md)”  
> “Lote a11y HIST — commit separado”  
> “Orquestrar a11y por épico conforme [acessibilidade-implementacao.md](./acessibilidade-implementacao.md)”
