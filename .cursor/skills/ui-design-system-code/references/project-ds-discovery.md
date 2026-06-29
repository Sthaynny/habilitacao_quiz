# Descoberta e Validação do Design System do Projeto

Índice: [Onde buscar](#onde-buscar-por-stack) · [Classificação](#classificação-do-projeto) · [Validação](#validação-de-tokens) · [Aplicação](#como-aplicar-por-cenário) · [Sugestões](#sugestões-de-melhoria) · [Grep](#comandos-de-varredura)

**Obrigatório antes de qualquer implementação ou refatoração de UI.** Não aplicar tokens genéricos da skill se o projeto já tiver DS — mapear e reutilizar o existente.

## Habilitação Quiz — atalho

Repositório **Flutter + GetX** com **cenário B** (DS parcial). Mapa completo: [habilitacao-quiz-ds.md](habilitacao-quiz-ds.md).

| O quê | Caminho |
|-------|---------|
| Cores | `lib/core/styles/app_colors.dart` → `AppColors` |
| Tipografia | `lib/core/styles/app_font_styles.dart`, `app_font_size.dart` |
| Spacing | `lib/core/styles/spacing_stack.dart` → `AppSpacingStack` |
| Gradientes | `lib/core/styles/app_gradients.dart` |
| Botões | `lib/core/components/button.dart` → `AppButton` |
| Tema global | `lib/app/my_app.dart` (gap P0: não usa `AppColors` ainda) |
| Estado UI | GetX — `*Controller`, `Obx` |

## Onde buscar por stack

### Web (CSS / Tailwind)

| O quê | Caminhos típicos |
|-------|------------------|
| Variáveis CSS | `globals.css`, `tokens.css`, `variables.css`, `styles/tokens/` |
| Tailwind | `tailwind.config.js`, `tailwind.config.ts`, `@theme` em CSS v4 |
| Tema React | `theme.ts`, `lib/tokens/`, `design-tokens.json`, `tokens/` |
| Componentes DS | `components/ui/`, `shared/components/`, `packages/ui/` |
| Regras do projeto | `.cursor/rules/*design*`, `CONTRIBUTING.md`, Storybook `tokens` |

### Flutter

| O quê | Caminhos típicos |
|-------|------------------|
| Theme central | `lib/core/theme/`, `lib/theme/`, `app_theme.dart` |
| Cores / spacing | `app_colors.dart`, `app_spacing.dart`, `app_sizes.dart` |
| Widgets DS | `lib/core/widgets/`, `shared/widgets/`, `design_system/` |
| Semânticos | `AppSemanticColors`, extensions em `ColorScheme` |
| Regras | `.cursor/skills/ui-design-system-code/` (esta skill) |

### Sinais de DS maduro

- [ ] Arquivo(s) central(is) de tema — não tokens espalhados em features
- [ ] Nomenclatura **semântica** (`primary`, `onSurface`, `--color-text-muted`) — não só primitivos (`blue-600`, `#2563eb`)
- [ ] Escala de **spacing** documentada ou nomeada (`space-4`, `AppSpacing.md`)
- [ ] Componentes compartilhados (`Button`, `AppButton`, `Input`) com variantes
- [ ] `ThemeData` / CSS variables usados nas features — não valores literais

## Classificação do projeto

Após varredura, classificar em **um** cenário:

| Cenário | Critério | Ação do agente |
|---------|----------|----------------|
| **A — DS maduro** | Tema central + tokens semânticos de cor e spacing + wrappers de componente | Usar **exclusivamente** tokens e widgets do projeto; skill só para heurísticas e gaps pontuais |
| **B — DS parcial** | Tema existe, mas features usam literais; ou só cores sem spacing | Aplicar tokens existentes no código tocado; **sugerir** consolidar gaps no tema central |
| **C — Sem DS** | Sem tema central; hex/`Colors.*`/arbitrary em features | **Propor** estrutura mínima no tema central; usar `lib/core/theme/` deste repo como referência de arquitetura (cenário C) |
| **D — DS divergente** | Múltiplos padrões conflitantes (2+ temas, mix Tailwind cru + CSS vars sem mapa) | Seguir o padrão **dominante** do módulo tocado; **sugerir** unificação |

Registrar a classificação no output antes de codar.

## Validação de tokens

### Cores — o que verificar

| Check | Passa se | Falha comum |
|-------|----------|-------------|
| Fonte única | Cores definidas em ≤ 2 arquivos de tema | `#hex` em 20+ componentes |
| Semânticos | Features usam `primary`, `muted`, `onSurface` | `bg-blue-500` direto em páginas |
| Dark mode | Pares light/dark no tema central | `dark:` ad hoc sem variável |
| Contraste | Tokens de texto sobre surface validados | `gray-400` em body |

### Spacing — o que verificar

| Check | Passa se | Falha comum |
|-------|----------|-------------|
| Escala | Múltiplos de 4/8 ou tokens nomeados | `13px`, `p-[11px]`, `margin: 15` |
| Consistência | Mesmo gap para mesmo contexto (campo→campo) | `gap-3` num form, `gap-5` noutro |
| Page padding | Token ou constante (`16`, `pageHorizontal`) | `padding: 12` só numa tela |
| Grade | `gap`/`spacing` em Column, não margin stack | `mt-3` + `mb-5` cascata |

### Componentes — o que verificar

| Check | Passa se | Falha comum |
|-------|----------|-------------|
| Wrappers | `AppButton`, shadcn `Button` em features | `ElevatedButton` / `TextField` / `<button className="...">` ad hoc |
| Variantes | enum/`variant` tipado | estilos inline duplicados |
| Estados | loading/disabled/error no wrapper | spinner manual em cada tela |

## Como aplicar por cenário

### Cenário A — DS maduro

1. Mapear token do projeto → papel UI (tabela no output)
2. Código novo usa **somente** APIs do DS (`AppSpacing.lg`, `text-muted-foreground`)
3. Auditar heurísticas (Nielsen, a11y) — DS não substitui UX

### Cenário B — DS parcial

1. Identificar tokens existentes vs literais no arquivo tocado
2. Refatorar literais → token mais próximo do tema
3. Se token semântico faltar, **adicionar no tema central** — não criar constante local na feature
4. Entregar bloco **Sugestões de melhoria** listando gaps do DS

### Cenário C — Sem DS

1. Propor estrutura mínima no tema central — snippets em [design-tokens.md](design-tokens.md); arquitetura de referência: `lib/core/styles/` deste repo
2. Implementar camada de tokens no primeiro PR (tema + 1 componente base)
3. Feature usa tokens desde o início
4. Sugestões priorizadas: P0 tema, P1 wrappers, P2 migração gradual

### Cenário D — DS divergente

1. Detectar qual padrão o módulo atual segue (ler imports e vizinhos)
2. Não introduzir terceiro padrão
3. Sugerir ADR ou issue de unificação com escopo e arquivos afetados

## Sugestões de melhoria

Quando o projeto **não** seguir as heurísticas da skill, **sempre** incluir seção de sugestões — mesmo que o pedido seja só uma tela. Priorizar por impacto:

| Prioridade | Tipo | Exemplo de sugestão |
|------------|------|---------------------|
| **P0 — Crítico** | Bloqueia consistência ou a11y | "Criar `AppSpacing` — 47 magic numbers em `lib/features/`" |
| **P1 — Estrutural** | DS incompleto | "Mapear `--color-text-secondary` em `globals.css`; features usam `gray-500`/`gray-600` misturados" |
| **P2 — Heurística** | Nielsen/WCAG no código | "Formulário sem `aria-invalid` — ver heuristic #9" |
| **P3 — Polish** | Hierarquia / spacing | "3 CTAs `default` na mesma view — reduzir a 1 primário" |

### Template de sugestão

```markdown
### [P1] Centralizar escala de spacing
- **Problema:** `EdgeInsets` com 12, 14, 18, 20px em features sem constante
- **Evidência:** `lib/features/checkout/`, `lib/features/profile/`
- **Heurística:** Consistência (#4), grade 8pt
- **Ação:** Criar `AppSpacing` em `lib/core/theme/app_spacing.dart` com md=16, lg=24
- **Esforço:** Médio — ~15 arquivos
```

### Heurísticas → sinais no código (auditoria rápida)

| Heurística | Red flag no código |
|------------|-------------------|
| #1 Status | submit sem `disabled`/`isLoading` |
| #4 Consistência | 3 labels diferentes para "Salvar" |
| #5 Prevenção | validação só no servidor |
| #8 Minimalismo | 4+ `bg-primary` na mesma view |
| #9 Erros | `catch` com toast genérico, form limpo |
| WCAG | `outline-none`, input sem label, contraste `gray-400` body |

Carregar detalhes: [nielsen-code-patterns.md](nielsen-code-patterns.md), [accessibility-code.md](accessibility-code.md).

## Comandos de varredura

Executar buscas no projeto antes de implementar (adaptar caminhos):

```bash
# Literais de cor (Web)
rg -i "#[0-9a-f]{3,8}|rgb\(|hsl\(" --glob "*.{tsx,jsx,vue,css}" --glob "!**/node_modules/**"

# Arbitrary spacing Tailwind
rg "p-\[|m-\[|gap-\[|w-\[" --glob "*.{tsx,jsx,vue}"

# Cores Flutter cruas
rg "Colors\.(red|blue|grey|gray|green)" --glob "*.dart" --glob "!**/theme/**"

# Magic numbers spacing Flutter
rg "EdgeInsets\.(all|symmetric|only)\([^)]*[0-9]+" --glob "*.dart" --glob "!**/theme/**"

# Uso de tokens do projeto (ajustar nomes)
rg "AppSpacing|AppSizes|colorScheme|text-muted-foreground|--color-" --glob "*.{dart,tsx,css}"
```

Interpretação:
- Muitos literais + poucos tokens → cenário **B** ou **C**
- Tokens centralizados + literais raros → cenário **A**
- Dois arquivos de tema sem hierarquia clara → cenário **D**

## Mapa rápido: papel UI → onde buscar token

| Papel | Web (shadcn) | Web (CSS vars) | Flutter (Habilitação Quiz) |
|-------|--------------|----------------|----------------------------|
| Fundo página | `bg-background` | `--color-bg` | `AppColors.white` |
| Texto secundário | `text-muted-foreground` | `--color-text-muted` | `AppColors.grey` + `AppFontStyle.body14Regular` |
| Borda | `border-border` | `--color-border` | `AppColors.border` |
| CTA | `bg-primary` | `--color-brand` | `AppButton.primary` → `AppColors.primary` (roxo) |
| Gap padrão | `gap-4` / `gap-6` | `--space-4` | `AppSpacingStack.xxxSmall` (16) |
| Padding página | `px-4 md:px-6` | `--space-4` | `AppSpacingStack.xxxSmall` / `.large` |
| Hero / splash | gradient brand | `--gradient-brand` | `AppGradients.linear` |

Se o projeto usar nomes diferentes (`neutral-500`, `spacingMd`), **mapear para o nome local** — não renomear para o da skill.
