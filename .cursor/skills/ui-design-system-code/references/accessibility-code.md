# Acessibilidade — Implementação em Código

Alvo padrão: **WCAG 2.2 AA**. Índice: [Contraste](#contraste) · [HTML](#html-semântico) · [ARIA](#aria) · [Teclado](#teclado-e-foco) · [Flutter](#flutter) · [Checklist](#checklist)

## Contraste

| Conteúdo | AA mínimo |
|----------|-----------|
| Texto normal (< 18px) | 4.5:1 |
| Texto grande (≥ 18px ou bold ≥ 14px) | 3:1 |
| Componentes UI e ícones | 3:1 |
| Indicador de foco | 3:1 |

**Falhas comuns em código:**
- `text-gray-400` em body 14px sobre branco
- `placeholder` como único label
- Brand claro em botão com texto branco sem validar

```css
/* Foco visível — nunca remover sem substituto */
:focus-visible {
  outline: 2px solid var(--focus-ring);
  outline-offset: 2px;
}
```

```html
<button class="focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-ring">
```

## HTML semântico

```html
<body>
  <a href="#main" class="sr-only focus:not-sr-only">Pular para conteúdo</a>
  <header>...</header>
  <nav aria-label="Principal">...</nav>
  <main id="main">...</main>
  <footer>...</footer>
</body>
```

- Hierarquia de headings sem pular níveis (`h1` → `h2`, não `h1` → `h4`)
- `<button>` para ações; `<a href>` para navegação
- Todo input com `<label for="id">` ou `aria-labelledby`

## Formulários

```html
<div class="space-y-2">
  <label for="email" class="text-sm font-medium">
    E-mail <span aria-hidden="true">*</span>
    <span class="sr-only">(obrigatório)</span>
  </label>
  <input
    id="email"
    type="email"
    required
    aria-required="true"
    aria-invalid={hasError}
    aria-describedby={hasError ? "email-error email-hint" : "email-hint"}
  />
  <p id="email-hint" class="text-sm text-muted-foreground">...</p>
  {hasError && <p id="email-error" role="alert" class="text-sm text-destructive">...</p>}
</div>
```

## ARIA — quando nativo não basta

| Widget | Padrão |
|--------|--------|
| Modal | `role="dialog"`, `aria-modal="true"`, `aria-labelledby` |
| Tabs | `role="tablist"`, arrow keys (Radix cuida) |
| Disclosure | `aria-expanded` no trigger |
| Toast | `aria-live="polite"` |
| Erro urgente | `aria-live="assertive"` ou `role="alert"` |
| Loading | `aria-busy="true"` |

**Primeira regra de ARIA:** preferir `<button>`, `<input>`, `<select>` nativos.

## Teclado e foco

- [ ] Tab alcança todos os interativos em ordem visual
- [ ] Modais: focus trap + restore ao fechar (Radix/shadcn padrão)
- [ ] Sem `outline-none` global sem `focus-visible` alternativo
- [ ] Alvo de toque ≥ 24×24 CSS px (AA); preferir **44–48px** mobile

```tsx
// Ícone sem texto visível
<Button size="icon" aria-label="Excluir item">
  <TrashIcon aria-hidden="true" />
</Button>
```

## Motion

```css
@media (prefers-reduced-motion: reduce) {
  *, *::before, *::after {
    animation-duration: 0.01ms !important;
    transition-duration: 0.01ms !important;
  }
}
```

## Flutter

```dart
// Ícone-only — tooltip obrigatório
IconButton(
  tooltip: 'Excluir',
  onPressed: onDelete,
  icon: const Icon(Icons.delete_outline),
)

// Anúncio de erro
SemanticsService.announce('Formulário com erros', TextDirection.ltr);

// Testar escala 200%
MediaQuery(
  data: MediaQuery.of(context).copyWith(
    textScaler: TextScaler.linear(2.0),
  ),
  child: myWidget,
)
```

| WCAG | API Flutter |
|------|-------------|
| Contraste | `ColorScheme` + helpers do projeto |
| Alvo 48dp | `minimumSize: Size(48, 48)` |
| Nome/role | `Semantics`, `tooltip`, `MergeSemantics` |
| Foco | `Focus`, `focusColor` do tema M3 |

## Checklist por tela

```
Perceptível
- [ ] Cor não é único indicador (ícone + texto)
- [ ] Contraste AA em texto e controles
- [ ] alt em imagens; decorativa alt=""

Operável
- [ ] Navegação completa por teclado
- [ ] Foco visível
- [ ] Alvos ≥ 44px mobile

Compreensível
- [ ] Labels e mensagens de erro
- [ ] lang no html / locale no MaterialApp

Robusto
- [ ] HTML semântico ou Semantics corretos
- [ ] ARIA só quando necessário
```

## Severidade em revisão de código

| Issue no diff | Severidade |
|---------------|------------|
| Sem focus ring | Crítico |
| Body text contraste 3:1 | Crítico |
| Botão ícone sem `aria-label`/`tooltip` | Crítico |
| Input sem label | Crítico |
| Alvo pequeno em CTA mobile | Melhoria |
