# Design System — Habilitação Quiz

Índice: [Classificação](#classificação) · [Paleta e papéis semânticos](#paleta-e-papéis-semânticos) · [Tokens](#tokens) · [Componentes](#componentes) · [Estado e feedback](#estado-e-feedback) · [Heurísticas Nielsen](#heurísticas-nielsen--mapeamento) · [Gaps conhecidos](#gaps-conhecidos-priorizar-em-refactors)

**Cenário B — DS parcial.** Tokens centralizados em `lib/core/styles/` e `AppButton` em `lib/core/components/`, mas `ThemeData` ainda não consome `AppColors` e há duplicidade de nomes (PT/EN) e literais `Colors.*` pontuais.

## Classificação

| Critério | Fonte no repositório |
|----------|----------------------|
| Cores | `lib/core/styles/app_colors.dart` → `AppColors` |
| Tipografia | `lib/core/styles/app_font_styles.dart`, `app_font_size.dart`, `font_weight.dart` |
| Spacing | `lib/core/styles/spacing_stack.dart` → `AppSpacingStack` |
| Gradientes | `lib/core/styles/app_gradients.dart` → `AppGradients` |
| Imagens | `lib/core/styles/app_images.dart` → `AppImages` |
| Raios | `lib/core/styles/consts.dart` → `border12Radius` (12); cards/respostas usam `10` |
| Botões | `lib/core/components/button.dart` → `AppButton` |
| Tema global | `lib/app/my_app.dart` → `ThemeData` (ainda mínimo — ver gaps) |
| Estado UI | **GetX** — `GetxController`, `Obx`, `Get.find()` |
| Feedback | `LoadingBlurScreen`, `PopUpMixin`, `Get.defaultDialog` |

## Paleta e papéis semânticos

Paleta real extraída do código. **Preferir sempre o token semântico** — não hex solto nem `Colors.*`.

### Marca e ações

| Papel UI | Token preferido | Hex | Onde aparece |
|----------|-----------------|-----|--------------|
| CTA primário (fundo) | `AppColors.primary` (= `purple` / `roxo`) | `#8257E5` | `AppButton.primary`, tab ativa |
| CTA secundário (fundo) | `AppColors.secondary` (= `darkGreen` / `verdeEscuro`) | `#04D361` | `AppButton.secundary`, progresso histórico |
| Gradiente de marca | `AppGradients.linear` | `#57B6E5` → `#8257E5` | Splash, momentos hero |
| Ação de quiz (card) | `AppColors.azul` com alpha | `#0682DD` | `QuizButtonWidget` — preferir token + `.withAlpha()` |
| Fechar / erro forte | `AppColors.darkRed` / `vermelhoEscuro` | `#CC3750` | Ícone fechar questionário, falha |

### Superfícies e texto

| Papel UI | Token preferido | Hex | Onde aparece |
|----------|-----------------|-----|--------------|
| Fundo de card / resposta | `AppColors.white` | `#FFFFFF` | Cards, opções de resposta |
| Texto principal | `AppColors.black` / `preto` | `#514766` | Títulos, corpo — **não** `#000000` |
| Texto secundário | `AppColors.grey` / `cinza` | `#6E6680` | Indicadores, labels auxiliares |
| Texto / borda desabilitado | `AppColors.lightGrey` | `#A6A1B2` | Botão disabled, histórico muted |
| Borda de card / input | `AppColors.border` / `outline` | `#E1E1E6` | `QuizCardWidget`, `RespostaWidget` |
| Overlay de loading | `AppColors.preto.withValues(alpha: .5)` | — | `LoadingBlurScreen` |

### Feedback de quiz (acerto / seleção)

| Papel UI | Token | Hex |
|----------|-------|-----|
| Resposta selecionada (fundo) | `AppColors.lightGreen` | `#E1F5EC` |
| Resposta selecionada (borda) | `AppColors.green` | `#B8DBCB` |
| Resposta selecionada (texto) | `AppColors.darkGreen` | `#04D361` |
| Barra de progresso (valor) | `AppColors.verde` | `#0CF877` |
| Barra de progresso (track) | `AppColors.cinzaSuperClaro` | `#E1E6E3` |

### Duplicidade PT/EN — regra para código novo

`AppColors` expõe **dois vocabulários** (legado PT + EN). Em código novo:

- Usar nomes **em inglês**: `purple`, `darkGreen`, `black`, `grey`, `lightGrey`, `white`, `border`
- Evitar adicionar aliases PT (`roxo`, `cinza`, …) — ao refatorar, migrar para o par EN equivalente
- Não misturar `corPrimaria` (`#0682DD`) com `primary` (`#8257E5`) — são cores **diferentes**; CTA usa `primary` (roxo)

## Tokens

### Spacing (`AppSpacingStack`)

| Token | px | Uso típico neste app |
|-------|-----|----------------------|
| `quarck` | 4 | Margem vertical entre opções de resposta |
| `nano` | 8 | Padding interno de botão, margem de card |
| `xxxSmall` | 16 | Padding de card/resposta, gap pequeno |
| `xxSmall` | 24 | Gap entre botões empilhados |
| `xSmall` | 32 | — |
| `small` | 40 | Padding horizontal de blocos de texto |
| `medium` | 48 | Altura mínima de botão (`AppButton`) |
| `large` | 64 | Padding horizontal de CTAs na tela resultado |
| `xxxLarge` | 120 | Padding top de telas full-screen |

### Tipografia (`AppFontStyle` + `AppFontSize`)

Fonte: **Noto Sans** via `GoogleFonts.notoSans`. Default implícito: `AppColors.black`.

| Preset | Tamanho | Peso | Uso |
|--------|---------|------|-----|
| `headline32Black` | 32 | black | Hero raro |
| `headline24Bold` / `headline24Regular` | 24 | bold/regular | Títulos de seção |
| `headline20Bold` | 20 | bold | Resultado, destaque |
| `body16Bold` / `body16Medium` / `body16Regular` | 16 | — | Perguntas, opções, botões |
| `body14Bold` / `body14Regular` | 14 | — | Nav bar, subtítulos, histórico |
| `caption12Regular` | 12 | regular | Metadados |

Cor secundária no texto: `.setColor(AppColors.grey)` — extensão `TextStyleExt`.

Máximo **3 presets** por viewport (ex.: `headline20Bold` + `body14Regular` + `body14Bold`).

### Raios de borda

| Contexto | Valor | Fonte |
|----------|-------|-------|
| Botões `AppButton` | 12 | `border12Radius` em `consts.dart` |
| Cards quiz / respostas | 10 | inline — manter consistente ao tocar |
| Quiz category button | 18 | `QuizButtonWidget` — exceção visual documentada |

## Componentes

### `AppButton` (`lib/core/components/button.dart`)

| Factory | Fundo | Texto | Uso |
|---------|-------|-------|-----|
| `AppButton.primary(title, …)` | `AppColors.primary` | `AppColors.white` | **1 CTA por seção** — compartilhar, confirmar |
| `AppButton.secundary(title, …)` | `AppColors.secondary` | `AppColors.white` | Ação alternativa de destaque |
| `AppButton.primaryOutline(title, …)` | `white` + borda | `lightGrey` | Ação secundária com contorno |
| `AppButton.link(title, …)` | transparente | `grey` | Voltar, cancelar — sem competir com primário |

Estados:
- `onPressed: null` → cores disabled (`lightGrey` / `grey`) automáticas
- Altura fixa **48px** — atende alvo mínimo de toque
- `expanded: true` → largura total do container pai

**Evitar** em código novo: `ElevatedButton`, `TextButton`, `CupertinoButton` cru — exceto `QuizButtonWidget` (estilo próprio de categoria).

### Widgets de feature reutilizáveis

| Widget | Caminho | Papel |
|--------|---------|-------|
| `QuizCardWidget` | `home/.../quiz_card.dart` | Card de módulo na home |
| `QuizButtonWidget` | `home/.../quiz_button_widget.dart` | Botão de categoria (estilo azul) |
| `RespostaWidget` | `questionario/.../resposta_widget.dart` | Opção de múltipla escolha |
| `LoadingBlurScreen` | `shared/.../loading_blur_screen.dart` | Overlay de carregamento |
| `BottomNavBar` | `home/.../bottom_nav_bar.dart` | Navegação quizzes / histórico |

### Imagens (`AppImages`)

Usar assets centralizados — não paths soltos em features.

## Estado e feedback

| Situação | Padrão no projeto |
|----------|-------------------|
| Loading de tela | `LoadingBlurScreen(enabled: controller.isLoading, …)` |
| Reatividade | `Obx(() => …)` escopado — evitar `Obx` envolvendo `Scaffold` inteiro sem necessidade |
| Erro | `PopUpMixin.popUpErro()` via `Get.defaultDialog` |
| Diálogo confirmar | `PopUpMixin` com `AppColors.branco` em `confirmTextColor` |
| Navegação | `Get.toNamed`, `Get.back`, `Get.offAndToNamed` |
| Compartilhar resultado | `AppButton.primary` + `share_plus` |

**Não** introduzir Cubit/Bloc — o stack é GetX.

## Heurísticas Nielsen → mapeamento

| Heurística | Implementação neste app |
|------------|-------------------------|
| Visibilidade do status | `IndicadorQuestoesWidget`, `LinearProgressIndicator`, `LoadingBlurScreen` |
| Correspondência com mundo real | Ícones por categoria, imagens sucesso/fracasso em resultado |
| Controle e liberdade | `AppButton.link` voltar, ícone fechar no questionário |
| Consistência | Tokens `AppColors` + `AppFontStyle`; unificar raios 10/12 |
| Prevenção de erro | Desabilitar avanço sem resposta (controller); pop-up de erro |
| Reconhecimento vs recall | Estado selecionado verde em `RespostaWidget`; tab ativa roxa |
| Flexibilidade | Compartilhar resultado; histórico de tentativas |
| Design minimalista | Cards brancos, borda sutil, poucos CTAs por tela |
| Recuperação de erros | `PopUpMixin`, mensagem em resultado de baixo rendimento |

## Gaps conhecidos (priorizar em refactors)

| Prioridade | Gap | Ação sugerida |
|------------|-----|---------------|
| P0 | `ThemeData(primarySwatch: Colors.blue)` ignora `AppColors` | Mapear `ColorScheme` a partir de `purple` / `darkGreen` |
| P1 | Duplicidade PT/EN em `AppColors` | Consolidar aliases; deprecar nomes PT em comentário |
| P1 | `corPrimaria` (#0682DD) ≠ `primary` (#8257E5) | Documentar ou renomear para `quizBlue` |
| P2 | Literais `Colors.blue`, `Colors.grey` em `bottom_nav_bar`, `circular_progress_widget` | Substituir por `AppColors` |
| P2 | Raios 10 vs 12 vs 18 | Extrair `AppRadius.card` (10) e manter `border12Radius` para botões |
| P3 | `QuizButtonWidget` usa `ElevatedButton` + `AppColors.azul.withAlpha(200)` | Avaliar factory `AppButton` ou token `quizCategoryBackground` |

## Mapa papel UI → token local

| Papel UI | Token / API do projeto |
|----------|------------------------|
| Fundo splash / hero | `AppGradients.linear` |
| Fundo de página | `AppColors.white` (Scaffold default) |
| Card de quiz | `AppColors.white` + `AppColors.border` |
| Título de seção | `AppFontStyle.headline20Bold` ou `headline24Bold` |
| Texto secundário | `AppFontStyle.body14Regular.setColor(AppColors.grey)` |
| CTA primário | `AppButton.primary(...)` |
| Ação terciária | `AppButton.link(...)` |
| Tab / nav ativa | `AppColors.purple` |
| Resposta correta/selecionada | `lightGreen` + `green` + `darkGreen` |
| Erro / fechar | `AppColors.darkRed` |
| Gap entre opções | `AppSpacingStack.quarck` (4) |
| Padding de card | `AppSpacingStack.xxxSmall` (16) |
| Padding horizontal CTA | `AppSpacingStack.large` (64) |
