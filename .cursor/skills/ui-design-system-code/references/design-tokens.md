# Design Tokens — Arquitetura em Código

Índice: [Camadas](#camadas) · [CSS](#css) · [Tailwind](#tailwind) · [Flutter](#flutter) · [Componentes](#tokens-de-componente) · [Migração](#migração)

> **Antes de aplicar estes padrões:** validar se o projeto já tem DS e mapeamento de tokens — ver [project-ds-discovery.md](project-ds-discovery.md). Tokens locais têm prioridade sobre os exemplos abaixo.

## NaRisca (agendamentos) — mapa rápido

Cenário **A**. Detalhes: [narisca-ds.md](narisca-ds.md). **Não** usar exemplos genéricos abaixo — usar APIs do repositório.

| Camada | Onde definir | Consumir em features |
|--------|--------------|----------------------|
| Primitivo | `lib/core/theme/app_colors.dart` | só no tema |
| Semântico | `ColorScheme` + `AppSemanticColors` | `Theme.of(context).colorScheme` |
| Spacing | `lib/core/theme/app_spacing.dart` | `AppSpacing.md`, `.lg`, … |
| Tamanhos | `lib/core/theme/app_sizes.dart` | `AppSizes.radiusMd`, `buttonHeightDefault`, … |
| Componente | `app_theme.dart`, `app_selection_theme.dart` | `AppButton`, `AppTextField`, … |

## Camadas

Três níveis — **nunca** usar primitivos diretamente em features:

| Camada | Exemplo | Onde definir |
|--------|---------|--------------|
| **Primitivo** | `--gray-900`, `Colors.blue.shade600` | `tokens.css`, `tailwind.config`, `app_theme.dart` |
| **Semântico** | `--color-text-primary`, `onSurface` | `:root`, `theme.extend.colors`, `ColorScheme` |
| **Componente** | `--button-primary-bg` | `@layer components`, variantes `cva`, `FilledButtonTheme` |

## CSS

```css
:root {
  /* Primitivos (não usar em componentes) */
  --gray-900: #111827;
  --blue-600: #2563eb;

  /* Semânticos */
  --color-bg: #ffffff;
  --color-bg-elevated: #ffffff;
  --color-text-primary: var(--gray-900);
  --color-text-secondary: #4b5563;
  --color-text-muted: #6b7280;
  --color-border: #e5e7eb;
  --color-brand: var(--blue-600);
  --color-brand-hover: #1d4ed8;
  --color-error: #dc2626;
  --focus-ring: var(--blue-600);

  /* Espaçamento */
  --space-1: 0.25rem;
  --space-2: 0.5rem;
  --space-4: 1rem;
  --space-6: 1.5rem;
  --space-8: 2rem;

  /* Raio */
  --radius-sm: 4px;
  --radius-md: 8px;
  --radius-lg: 12px;
}

[data-theme="dark"] {
  --color-bg: #0f172a;
  --color-bg-elevated: #1e293b;
  --color-text-primary: #f8fafc;
  --color-text-secondary: #cbd5e1;
  --color-border: #334155;
  --color-brand: #3b82f6;
}
```

**Uso em componente:**

```css
.card {
  background: var(--color-bg-elevated);
  color: var(--color-text-primary);
  border: 1px solid var(--color-border);
  border-radius: var(--radius-lg);
  padding: var(--space-6);
}
```

Snippets acima são ponto de partida para cenário C. No NaRisca, fonte única: `lib/core/theme/app_colors.dart`, `app_theme.dart`.

## Tailwind

```js
// theme.extend — mapear semânticos
colors: {
  background: 'var(--color-bg)',
  foreground: 'var(--color-text-primary)',
  muted: { foreground: 'var(--color-text-muted)' },
  border: 'var(--color-border)',
  brand: {
    DEFAULT: 'var(--color-brand)',
    hover: 'var(--color-brand-hover)',
  },
},
borderRadius: {
  lg: 'var(--radius-lg)',
},
```

**Regras:**
- `darkMode: ['class', '[data-theme="dark"]']` quando houver toggle
- Evitar `p-[17px]` — estender escala ou usar `space-*`
- Cores de texto sempre explícitas: `text-foreground`, não herança implícita

## Flutter

```dart
// Semântico via ColorScheme — nunca Colors.* em features
final scheme = Theme.of(context).colorScheme;
final textTheme = Theme.of(context).textTheme;

// Superfícies
scheme.surface          // fundo página
scheme.surfaceContainerHighest  // cards, inputs
scheme.onSurface        // texto primário
scheme.onSurfaceVariant // texto secundário

// Ações
scheme.primary / scheme.onPrimary
scheme.error / scheme.onError
```

**ThemeData central:**

```dart
ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.brand,
    brightness: Brightness.light,
  ),
  textTheme: _buildTextTheme(),
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      minimumSize: const Size.fromHeight(48),
    ),
  ),
);
```

**Referência de arquitetura (NaRisca):** `lib/core/theme/app_theme.dart`, `app_spacing.dart`, `app_sizes.dart`, `app_colors.dart` — não copiar para features; estender o tema central se faltar token.

## Tokens de componente

Definir variantes uma vez, consumir em todo o app:

| Componente | Variantes | Token base |
|------------|-----------|------------|
| Button | primary, secondary, ghost, destructive | `primary`, `outline`, `error` |
| Input | default, error, disabled | `border`, `ring`, `destructive` |
| Card | elevated, outlined, flat | `bg-elevated`, `border`, `shadow-sm` |
| Badge | info, success, warning, error | feedback semânticos |

**React (cva):**

```tsx
variant: {
  default: "bg-primary text-primary-foreground hover:bg-primary/90",
  outline: "border border-input bg-background hover:bg-accent",
  ghost: "hover:bg-accent",
  destructive: "bg-destructive text-destructive-foreground",
}
```

## Migração

1. Inventariar hex/`Colors.*`/`#[arbitrary]` em features
2. Mapear cada valor para token semântico existente ou criar um novo no tema central
3. Revalidar contraste light + dark
4. Substituir em lote por arquivo — não misturar old/new no mesmo componente
5. Extrair combo de classes repetido 3+ vezes → componente ou `@layer components`
