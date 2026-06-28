# Web — Padrões Tailwind e CSS

Índice: [Setup](#setup) · [Tipografia](#tipografia) · [Layout](#layout) · [Botões](#botões) · [Forms](#formulários) · [Cards](#cards) · [Extração](#extração-de-componentes)

## Setup

```js
// tailwind.config — estender, não sobrescrever cegamente
theme: {
  extend: {
    colors: {
      brand: { 50: '...', /* até 950 */ },
      background: 'var(--color-bg)',
      foreground: 'var(--color-text-primary)',
    },
  },
},
plugins: [require('@tailwindcss/forms')],
```

- Tokens via `theme.extend` + CSS variables em `globals.css`
- `darkMode: ['class', '[data-theme="dark"]']` com toggle

## Tipografia

```html
<h1 class="text-3xl font-semibold tracking-tight text-foreground">
<h2 class="text-xl font-semibold text-foreground">
<p class="text-base leading-relaxed text-muted-foreground">
<span class="text-sm text-muted-foreground">
```

- Sempre parear `text-*` com cor explícita
- `leading-relaxed` em parágrafos; `tracking-tight` só em headlines grandes

## Layout

```html
<!-- Stack vertical -->
<div class="flex flex-col gap-6">

<!-- Header split responsivo -->
<div class="flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">

<!-- Grid responsivo -->
<div class="grid grid-cols-1 gap-6 sm:grid-cols-2 lg:grid-cols-3">

<!-- Sidebar -->
<div class="flex min-h-screen">
  <aside class="hidden w-64 shrink-0 border-r lg:block" />
  <main class="flex-1 p-4 md:p-6 lg:p-8" />
</div>
```

**Page wrapper padrão:** `mx-auto max-w-7xl px-4 md:px-6 lg:px-8`

## Botões

```html
<!-- Primary -->
<button class="inline-flex h-10 items-center justify-center rounded-lg bg-brand-600 px-4 text-sm font-medium text-white shadow-sm transition-colors hover:bg-brand-700 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-brand-600 disabled:pointer-events-none disabled:opacity-50">

<!-- Secondary -->
<button class="inline-flex h-10 items-center justify-center rounded-lg border border-gray-300 bg-white px-4 text-sm font-medium text-gray-700 hover:bg-gray-50 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2">

<!-- Ghost -->
<button class="inline-flex h-10 items-center justify-center rounded-lg px-4 text-sm font-medium text-gray-700 hover:bg-gray-100">
```

Prefixos de estado: `hover:`, `focus-visible:`, `active:`, `disabled:`, `dark:`

## Formulários

```html
<div class="space-y-2">
  <label for="email" class="block text-sm font-medium text-gray-700">E-mail</label>
  <input
    id="email"
    type="email"
    class="block w-full rounded-lg border-gray-300 shadow-sm focus:border-brand-500 focus:ring-brand-500"
    aria-describedby="email-hint"
  />
  <p id="email-hint" class="text-sm text-gray-500">Nunca compartilharemos seu e-mail.</p>
</div>
```

Erro: `border-red-500` + `aria-invalid="true"` + `text-destructive` na mensagem.

## Cards

```html
<article class="rounded-xl border border-gray-200 bg-white p-6 shadow-sm transition-shadow hover:shadow-md">
```

- `rounded-xl` + `border` + `shadow-sm` = card SaaS moderno
- Hover elevation só quando interativo (link card)

## @layer components

Quando combo aparece 3+ vezes:

```css
@layer components {
  .btn-primary {
    @apply inline-flex h-10 items-center justify-center rounded-lg bg-brand-600 px-4 text-sm font-medium text-white hover:bg-brand-700 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-brand-600 disabled:opacity-50;
  }
}
```

## Anti-padrões

| Evitar | Preferir |
|--------|----------|
| `p-[17px]` | `p-4` ou token |
| `outline-none` sem ring | `focus-visible:ring-*` |
| `text-gray-400` em body | `text-gray-600` mínimo |
| String de 20+ classes repetida | Componente React/Vue |
| `space-y` + flex novos | `gap` em flex/grid |

## Checklist

- [ ] Escala 4/8px em spacing
- [ ] Um primary solid por seção
- [ ] Focus em todos interativos
- [ ] Testado 375 / 768 / 1280px
