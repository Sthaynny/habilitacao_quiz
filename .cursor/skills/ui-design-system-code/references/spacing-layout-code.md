# Spacing e Layout — Implementação em Código

Índice: [NaRisca](#narisca) · [Grade 8pt](#grade-8pt) · [Containers](#containers) · [Breakpoints](#breakpoints) · [Receitas](#receitas-por-componente) · [Flutter](#flutter) · [Performance](#performance)

## NaRisca

Tokens: `AppSpacing` (`lib/core/theme/app_spacing.dart`), breakpoints: `AppBreakpoints` (`app_breakpoints.dart`). Formulários: `.cursor/rules/agendamentos-form-layout.mdc`. Performance: [layout-performance.md](layout-performance.md). Mapa completo: [narisca-ds.md](narisca-ds.md).

| Token | px | Uso |
|-------|-----|-----|
| `AppSpacing.xs` | 4 | gap ícone–texto |
| `AppSpacing.sm` | 8 | padding interno |
| `AppSpacing.md` | 16 | página, gap entre campos |
| `AppSpacing.lg` | 24 | grupos, padding vertical |
| `AppSpacing.xl` | 32 | entre seções |
| `AppSpacing.xxl` | 48 | hero |

## Grade 8pt

| Token | px | Tailwind | Uso |
|-------|-----|----------|-----|
| 1 | 4 | `1`, `gap-1` | gap ícone-texto |
| 2 | 8 | `2` | padding-y input |
| 4 | 16 | `4` | gap form, padding card mobile |
| 6 | 24 | `6` | padding card desktop, seção |
| 8 | 32 | `8` | entre seções |
| 12 | 48 | `12` | margem de página hero |

**Regra:** 4px só para ajuste óptico interno; blocos de layout usam 8px+.

```html
<!-- Preferir gap a margin stack -->
<div class="flex flex-col gap-6">
```

```dart
Column(spacing: 16, children: [...])  // Flutter 3.16+
```

## Containers

```html
<div class="mx-auto w-full max-w-7xl px-4 md:px-6 lg:px-8">
```

```css
.container {
  width: 100%;
  max-width: 1280px;
  margin-inline: auto;
  padding-inline: 1rem;
}
@media (min-width: 768px) { .container { padding-inline: 1.5rem; } }
@media (min-width: 1024px) { .container { padding-inline: 2rem; } }
```

| Tipo de tela | max-width |
|--------------|-----------|
| Dashboard | 1200–1280px |
| Formulário / leitura | 640–720px |
| Auth card | 400–480px |

## Breakpoints

| Nome | px | Layout |
|------|-----|--------|
| mobile | < 768 | coluna única, `px-4` |
| tablet | 768–1023 | 2 colunas opcional, `px-6` |
| desktop | ≥ 1024 | sidebar + main, `px-8` |

```html
<div class="grid grid-cols-1 gap-6 md:grid-cols-2 lg:grid-cols-3">
<div class="flex flex-col gap-4 md:flex-row md:items-center md:justify-between">
<aside class="hidden w-64 shrink-0 border-r lg:block">
```

```dart
final width = MediaQuery.sizeOf(context).width;
final isCompact = width < 600;
final isExpanded = width >= 1024;
```

### Mobile CTA

```html
<div class="sticky bottom-0 border-t bg-background p-4 pb-[max(1rem,env(safe-area-inset-bottom))]">
  <Button class="w-full">Continuar</Button>
</div>
```

## Receitas por componente

### Formulário

| Relação | Gap |
|---------|-----|
| label → input | 4–8px (`space-y-2`) |
| campo → campo | 16px (`gap-4`) |
| grupo → grupo | 32px (`gap-8`) |
| último campo → ações | 24px (`mt-6`) |

```html
<form class="flex max-w-md flex-col gap-6">
  <div class="space-y-2">...</div>
  <div class="flex justify-end gap-3">...</div>
</form>
```

### Card grid

```html
<div class="grid grid-cols-1 gap-6 sm:grid-cols-2 lg:grid-cols-3">
  <article class="rounded-xl border p-6">...</article>
</div>
```

### Page header

```html
<header class="mb-8">
  <h1 class="text-3xl font-semibold">...</h1>
  <p class="mt-2 text-muted-foreground">...</p>
</header>
```

## Flutter

### Formulário NaRisca (preferido)

```dart
Form(
  key: _formKey,
  child: ListView(
    padding: const EdgeInsets.all(AppSpacing.md),
    children: [
      MinhaSecao(), // filho direto — ver agendamentos-form-layout.mdc
      const SizedBox(height: AppSpacing.xl),
    ],
  ),
)
```

### Página de leitura

```dart
Scaffold(
  body: SafeArea(
    child: ListView(
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        Text('Título', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: AppSpacing.lg),
        // ...
      ],
    ),
  ),
);
```

### Breakpoints NaRisca

```dart
if (MediaQuery.sizeOf(context).width < AppBreakpoints.compact) {
  return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [...]);
}
return Row(children: [Expanded(child: fieldA), Expanded(child: fieldB)]);
```

| Padrão | Implementação |
|--------|---------------|
| Lista longa | `ListView.builder` / `.separated` |
| Header + lista | `CustomScrollView` + slivers |
| Pull refresh | `RefreshIndicator` |
| Max width dashboard | `AppBreakpoints.contentMaxWidth` (1200) |

## Performance

Estrutura de layout impacta FPS e correção visual — ver [layout-performance.md](layout-performance.md):

| Escolha de layout | Quando |
|-------------------|--------|
| `ListView.builder` | listas dinâmicas ou > ~15 itens |
| `CustomScrollView` + slivers | header fixo + lista |
| `Form` + `ListView` | formulários (evita colapso de largura) |
| `mainAxisSize: min` em seções | filhos diretos de `ListView` |
| Evitar scroll aninhado | um eixo de scroll principal |

## Diagnóstico

| Sintoma | Correção no código |
|---------|-------------------|
| Mobile apertado | `px-4` no root; `gap-4` entre stacks |
| Colunas desalinhadas | Um grid pai; evitar padding aninhado conflitante |
| Alturas 43px, 37px | Snap para 40 ou 48 (`h-10`, `h-12`) |
| `margin-top` em cascata | `flex flex-col gap-*` |
