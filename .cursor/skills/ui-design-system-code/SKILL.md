---
name: ui-design-system-code
description: Aplica heurísticas de design, tokens, layout performático e boas práticas de UI diretamente no código. No repositório Habilitação Quiz, prioriza Flutter/GetX com AppColors, AppFontStyle, AppSpacingStack, AppButton e padrões em lib/core/styles/. Valida paleta e tokens reais do projeto antes de codar; reutiliza o existente ou propõe melhorias quando faltam padrões. Use ao criar ou refatorar telas, temas, layouts, performance de UI, a11y, auditoria visual ou quando o usuário pedir tokens, hierarquia ou Nielsen em código.
---

# UI Design System — Aplicação em Código

Content system de boas práticas para **implementar** interfaces consistentes, acessíveis e hierárquicas — não apenas auditar. O agente escreve ou refatora código seguindo tokens, receitas e padrões desta skill.

## Habilitação Quiz — leitura obrigatória

Este repositório é **Flutter + GetX** com DS parcial (**cenário B**). Antes de qualquer UI:

1. Ler [references/habilitacao-quiz-ds.md](references/habilitacao-quiz-ds.md) — paleta real, papéis semânticos, `AppButton`, gaps P0–P3
2. Varredura de cores: grep `AppColors.`, `Color(0x`, `Colors.` em `lib/` — literais devem virar tokens existentes
3. Estado: **GetX** (`GetxController`, `Obx`) — não introduzir Cubit/Bloc sem pedido
4. Feedback: `LoadingBlurScreen`, `PopUpMixin` — loading localizado, não spinner full-screen desnecessário
5. Performance de layout: [layout-performance.md](references/layout-performance.md) — listas, escopo de `Obx`, evitar rebuild da árvore inteira

Tokens reais: `lib/core/styles/` — ver [habilitacao-quiz-ds.md](references/habilitacao-quiz-ds.md).

## Regras de ouro

1. **Descobrir o DS antes de codar** — varrer `lib/core/styles/`, `lib/core/components/`; classificar cenário (A–D); ver [project-ds-discovery.md](references/project-ds-discovery.md)
2. **Tokens do projeto > exemplos genéricos** — neste app: `AppColors`, `AppFontStyle`, `AppSpacingStack`, `AppGradients`, `border12Radius`
3. **Tokens antes de valores literais** — cores, espaçamento e tipografia vêm de `AppColors` / `AppFontStyle` / `AppSpacingStack`, nunca hex/`Colors.*`/`EdgeInsets.all(12)` soltos em features
4. **Um CTA primário por seção** — `AppButton.primary(...)`; voltar/cancelar → `AppButton.link(...)`; alternativa destacada → `AppButton.secundary(...)`
5. **Estados completos** — default, disabled (`onPressed: null`), loading (`LoadingBlurScreen`), erro (`PopUpMixin`); feedback visual em seleção de resposta
6. **Acessibilidade no markup** — contraste AA sobre branco (`black` #514766, não preto puro); alvos ≥ 48px (`AppButton` height); labels em textos de botão
7. **Sugerir melhorias quando houver gaps** — cenário B: ThemeData sem AppColors, duplicidade PT/EN, raios inconsistentes — entregar P0–P3
8. **Layout performático por padrão** — escolher estrutura (scroll, escopo de `Obx`) antes de polir tokens; ver [layout-performance.md](references/layout-performance.md)
9. **Menor diff correto** — alinhar a GetX e convenções existentes; não introduzir bibliotecas novas sem pedido

## Detecção de stack

| Sinais | Stack | Priorizar |
|--------|-------|-----------|
| `pubspec.yaml` + `.dart` + `get` | **Flutter (Habilitação Quiz)** | `AppColors`, `AppFontStyle`, `AppSpacingStack`, `AppButton` — ver [habilitacao-quiz-ds.md](references/habilitacao-quiz-ds.md) |
| `.tsx`/`.jsx` + `tailwind.config` | Web + Tailwind | utilities + tokens em `theme.extend` |
| `components/ui/` + Radix | React + shadcn | `cn()`, variantes `cva`, primitivos Radix |
| CSS modules / styled | Web CSS | variáveis CSS semânticas |

## Regra obrigatória: validar DS e tokens do projeto

**Nunca implementar UI sem antes** executar descoberta do design system. Fluxo fixo:

1. **Buscar** — `lib/core/styles/app_colors.dart`, `app_font_styles.dart`, `spacing_stack.dart`, `lib/core/components/button.dart`
2. **Varredura** — grep por literais (`#hex`, `Colors.*`, magic `EdgeInsets`) vs `AppColors` / `AppSpacingStack`
3. **Classificar** — A (DS maduro) · B (parcial) · C (sem DS) · D (divergente) — ver [project-ds-discovery.md](references/project-ds-discovery.md)
4. **Mapear** — tabela papel UI → token **do projeto** ([habilitacao-quiz-ds.md](references/habilitacao-quiz-ds.md))
5. **Aplicar** — código novo/refatorado segue o mapeamento; cenário C propõe tokens em `lib/core/styles/`
6. **Sugerir** — se B/C/D ou violações de heurística: bloco **Sugestões de melhoria** priorizado (P0–P3)

| Cenário | Comportamento |
|---------|---------------|
| **A** | Só tokens + componentes centralizados; auditar heurísticas |
| **B** (este repo) | Usar `AppColors`/`AppFontStyle`/`AppSpacingStack`/`AppButton`; sugerir unificar ThemeData e aliases PT/EN |
| **C** | Propor estrutura mínima em `lib/core/styles/` |
| **D** | Seguir padrão dominante do módulo; sugerir unificação |

## Workflow de implementação

```
Progresso:
- [ ] 0. DS do projeto — descoberta, classificação (A–D), mapa de tokens cor/spacing
- [ ] 1. Contexto — tela, ação primária, fluxo quiz/home/resultado
- [ ] 2. Tokens — papéis semânticos mapeados à paleta AppColors (ou proposta se cenário C)
- [ ] 3. Layout — AppSpacingStack, scroll, escopo de Obx — [layout-performance.md](references/layout-performance.md)
- [ ] 4. Hierarquia — AppFontStyle, cor, espaçamento, um AppButton.primary por seção
- [ ] 5. Componentes — AppButton, widgets de feature, estados de seleção/loading
- [ ] 6. Acessibilidade — contraste, alvos 48px, texto legível (#514766)
- [ ] 7. Heurísticas — feedback de quiz, prevenção de erro, consistência — [nielsen-code-patterns.md](references/nielsen-code-patterns.md)
- [ ] 8. Performance — Obx escopado, ListView.builder para listas longas
- [ ] 9. Validar — checklist abaixo
- [ ] 10. Sugestões — melhorias P0–P3 se gaps ou violações
```

### Passo 1 — Definir papéis semânticos

Mapear cada elemento da UI para um token (ver [habilitacao-quiz-ds.md](references/habilitacao-quiz-ds.md)):

| Papel UI | Habilitação Quiz (Flutter) |
|----------|----------------------------|
| Fundo hero / splash | `AppGradients.linear` |
| Fundo de card | `AppColors.white` |
| Título | `AppFontStyle.headline20Bold` / `headline24Bold` |
| Texto secundário | `AppFontStyle.body14Regular.setColor(AppColors.grey)` |
| Borda de card | `AppColors.border` |
| CTA primário | `AppButton.primary(...)` — fundo `AppColors.primary` (roxo) |
| Resposta selecionada | `lightGreen` + `green` + `darkGreen` |
| Tab ativa | `AppColors.purple` |
| Erro / fechar | `AppColors.darkRed` |

### Passo 2 — Layout e spacing

Grade baseada em `AppSpacingStack` (múltiplos de 4) — ver [spacing-layout-code.md](references/spacing-layout-code.md):

- Padding de card/resposta: **`AppSpacingStack.xxxSmall` (16)**
- Gap entre opções: **`AppSpacingStack.quarck` (4)**
- Padding interno de botão: **`AppSpacingStack.nano` (8)**
- Padding horizontal de CTAs (resultado): **`AppSpacingStack.large` (64)**
- Raio de botão: **`border12Radius` (12)**; cards/respostas: **10** (consistente no módulo)

### Passo 3 — Hierarquia visual

Máximo **3 presets** `AppFontStyle` por viewport. Ver [visual-hierarchy-code.md](references/visual-hierarchy-code.md).

### Passo 4 — Componentes e estados

`AppButton` com factories; seleção em `RespostaWidget`; loading em `LoadingBlurScreen`. Ver [component-states.md](references/component-states.md).

### Passo 5 — Heurísticas de Nielsen

Padrões de quiz (progresso, feedback de acerto, voltar) — ver [nielsen-code-patterns.md](references/nielsen-code-patterns.md) e mapa em [habilitacao-quiz-ds.md](references/habilitacao-quiz-ds.md).

### Passo 6 — Acessibilidade

Contraste AA, alvos de toque — ver [accessibility-code.md](references/accessibility-code.md).

## Referências por tarefa

Carregar **apenas** o arquivo relevante:

| Tarefa | Arquivo |
|--------|---------|
| **Habilitação Quiz — DS, paleta e widgets** | [habilitacao-quiz-ds.md](references/habilitacao-quiz-ds.md) |
| **Descoberta e validação do DS** | [project-ds-discovery.md](references/project-ds-discovery.md) |
| Tokens (CSS, Tailwind, Flutter genérico) | [design-tokens.md](references/design-tokens.md) |
| Hierarquia tipográfica e cor | [visual-hierarchy-code.md](references/visual-hierarchy-code.md) |
| Grid, spacing, responsivo | [spacing-layout-code.md](references/spacing-layout-code.md) |
| Layout performático (scroll, rebuild) | [layout-performance.md](references/layout-performance.md) |
| Estados de componente | [component-states.md](references/component-states.md) |
| Nielsen → código | [nielsen-code-patterns.md](references/nielsen-code-patterns.md) |
| WCAG em markup | [accessibility-code.md](references/accessibility-code.md) |
| Flutter / Material 3 (referência) | [flutter-patterns.md](references/flutter-patterns.md) |

## Receitas rápidas

### Tela com CTA (resultado / confirmação)

```dart
Padding(
  padding: EdgeInsets.symmetric(horizontal: AppSpacingStack.large.value),
  child: AppButton.primary(
    Strings.compartilhar,
    onPressed: _onShare,
  ),
),
SizedBox(height: AppSpacingStack.xxSmall.value),
Padding(
  padding: EdgeInsets.symmetric(horizontal: AppSpacingStack.large.value),
  child: AppButton.link(
    Strings.voltarInicio,
    onPressed: Get.back,
  ),
),
```

### Opção de resposta (quiz)

```dart
Container(
  margin: EdgeInsets.symmetric(vertical: AppSpacingStack.quarck.value),
  padding: EdgeInsets.all(AppSpacingStack.xxxSmall.value),
  decoration: BoxDecoration(
    color: isSelected ? AppColors.lightGreen : AppColors.white,
    borderRadius: BorderRadius.circular(10),
    border: Border.all(
      color: isSelected ? AppColors.green : AppColors.border,
    ),
  ),
  child: Text(
    label,
    style: AppFontStyle.body16Medium.setColor(
      isSelected ? AppColors.darkGreen : AppColors.black,
    ),
  ),
),
```

### Home com loading GetX

```dart
Obx(() => LoadingBlurScreen(
  enabled: controller.isLoading,
  child: Scaffold(
    appBar: const AppBarWidget(),
    body: PageView(/* quizzes + histórico */),
    bottomNavigationBar: Obx(() => BottomNavBar(
      selectedIndex: controller.getPage,
      items: [/* activeColor: AppColors.purple */],
      onItemSelected: controller.setPage,
    )),
  ),
)),
```

### Splash / hero com gradiente de marca

```dart
Scaffold(
  body: Container(
    decoration: const BoxDecoration(gradient: AppGradients.linear),
    child: Center(child: Image.asset(AppImages.splash)),
  ),
),
```

## Anti-padrões (corrigir ao refatorar)

| Evitar | Preferir (Habilitação Quiz) |
|--------|----------------------------|
| `Colors.blue`, `Colors.grey` em features | `AppColors.purple`, `AppColors.grey`, `AppColors.lightGrey` |
| `#8257E5`, hex solto | `AppColors.primary` / `AppColors.purple` |
| `fontSize: 13`, `FontWeight.w600` soltos | `AppFontStyle.body14Regular`, `.body16Bold`, … |
| `EdgeInsets.all(12)` | `AppSpacingStack.xxxSmall`, `.nano`, `.quarck` |
| `ElevatedButton` / `TextButton` cru | `AppButton.primary` / `.link` / `.secundary` |
| Vários `AppButton.primary` na mesma seção | Um primário; demais `.link` ou `.primaryOutline` |
| `primarySwatch: Colors.blue` sem alinhar DS | `ColorScheme` derivado de `AppColors.primary` (melhoria P0) |
| Misturar `corPrimaria` com `primary` | `corPrimaria`/`azul` = azul quiz; `primary` = roxo CTA |
| Aliases PT novos (`roxo`, `cinzaClaro`) | Tokens EN existentes (`purple`, `lightGrey`) |
| `Obx` envolvendo Scaffold inteiro + side effects | `Obx` escopado; side effects em `ever` / listener |
| Loading full-screen para ação pontual | `LoadingBlurScreen` só quando carrega dados da tela |

## Checklist de entrega

### Design system do projeto
- [ ] DS descoberto e cenário (A–D) documentado?
- [ ] Mapa papel UI → `AppColors` / `AppFontStyle` preenchido?
- [ ] Literais substituídos por tokens existentes?
- [ ] Sugestões P0–P3 se ThemeData, aliases ou raios inconsistentes?

### Tokens e consistência
- [ ] Sem hex/`Colors.*` novos em features?
- [ ] Tipografia via `AppFontStyle` (≤ 3 presets por viewport)?
- [ ] Spacing via `AppSpacingStack`?
- [ ] CTA usa `AppColors.primary` (roxo), não azul genérico?

### Hierarquia
- [ ] Um `AppButton.primary` por seção?
- [ ] Texto secundário via `AppColors.grey`?
- [ ] Feedback de seleção verde (`lightGreen` / `darkGreen`)?

### Layout e performance
- [ ] `Obx` com escopo mínimo?
- [ ] Listas longas com `ListView.builder`?
- [ ] `LoadingBlurScreen` apenas quando necessário?

### Estados e feedback (quiz)
- [ ] Indicador de questão / progresso visível?
- [ ] Estado selecionado distinguível (cor + borda)?
- [ ] Erro via `PopUpMixin` ou mensagem clara?

### Acessibilidade
- [ ] Contraste texto `#514766` sobre branco?
- [ ] Botões com altura 48px?
- [ ] Ações destrutivas/fechar com `darkRed` e área de toque adequada?

## Formato de saída

Ao implementar ou revisar código, estruturar:

```markdown
## Contexto
[Stack GetX, tela, ação primária]

## Design system do projeto
- **Cenário:** B (parcial)
- **Fontes:** lib/core/styles/app_colors.dart, app_font_styles.dart, spacing_stack.dart
- **Mapa de tokens:**

| Papel UI | Token do projeto | Notas |
|----------|------------------|-------|
| CTA primário | AppColors.primary | roxo #8257E5 |
| ... | ... | ... |

- **Gaps:** [ThemeData, Colors.*, duplicidade PT/EN]

## Tokens aplicados
[Papéis semânticos usados no diff]

## Layout e performance
[Obx escopado, scroll, LoadingBlurScreen]

## Mudanças
[Diff mínimo por arquivo]

## Sugestões de melhoria
[P0–P3 com evidência — ex.: ThemeData, corPrimaria vs primary]

## Checklist
[Itens verificados]
```

**Sugestões de melhoria** são obrigatórias quando:
- ThemeData não reflete `AppColors` (P0 neste repo)
- Features usam literais apesar de existir DS (cenário B)
- Coexistem padrões conflitantes — raios, nomes PT/EN (cenário D)
- Código viola heurísticas Nielsen, WCAG ou feedback de quiz
