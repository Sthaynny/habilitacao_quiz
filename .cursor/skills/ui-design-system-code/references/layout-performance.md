# Layout + Performance — Padrões em Código

Índice: [Princípio](#princípio) · [Decisão de layout](#decisão-de-layout) · [Flutter](#flutter-narisca) · [Web](#web) · [Heurísticas × performance](#heurísticas--performance) · [Anti-padrões](#anti-padrões) · [Checklist](#checklist)

**Regra:** layout bonito que viola limitações da plataforma **não é** boa UX — causa jank, campos invisíveis, scroll travado ou rede saturada. Escolher o padrão estrutural **antes** dos tokens visuais.

## Princípio

| Camada | Pergunta |
|--------|----------|
| **Estrutura** | Quantos filhos? Scroll? Lista virtualizada? Quem rebuilda? |
| **Visual** | Tokens, hierarquia, estados — só depois da estrutura estar correta |
| **Rede** | Interação imediata na UI; fetch pesado com debounce + cancelamento |

Heurísticas Nielsen reforçam performance quando traduzidas em código:

| Heurística | Implicação de performance |
|------------|---------------------------|
| #1 Status visível | Loading **local** (`AppLoadingState`, skeleton de seção) — não rebuildar a árvore inteira |
| #4 Consistência | Mesmo padrão de lista/form em features — menos surpresas de layout e de custo |
| #7 Flexibilidade | Filtro local instantâneo; debounce só quando há rede/query pesada |
| #8 Minimalismo | Menos nesting, menos `shrinkWrap`, menos animações simultâneas |

## Decisão de layout

```
Quantos itens na tela?
├── Poucos (< ~15 widgets estáticos) → Column / ListView com children fixos
├── Muitos ou dinâmicos → ListView.builder / .separated / CustomScrollView + slivers
└── Formulário → Form + ListView (seções filho direto) — agendamentos-form-layout.mdc

O usuário dispara rede ao interagir?
├── Só filtra dados já em memória → atualizar state/Cubit imediato
└── Query remota / Firestore pesado → UI imediata + InteractionDebouncer + request id

O rebuild é amplo demais?
├── Dado de Cubit mudou só numa seção → BlocBuilder com buildWhen / widget de seção isolado
└── Preview ligada a TextEditingController → ListenableBuilder (não a Page inteira)
```

## Flutter (NaRisca)

Regras do projeto: `.cursor/rules/agendamentos-form-layout.mdc`, `agendamentos-interaction-debouncer.mdc`, `agendamentos-cubit-state.mdc`.

### Scroll e listas

| Cenário | Padrão | Por quê |
|---------|--------|---------|
| Formulário | `Form` → `ListView`, seções `mainAxisSize: min` | Scroll previsível; evita colapso de largura |
| Lista longa | `ListView.builder` / `.separated` | Só constrói itens visíveis |
| Header fixo + lista | `CustomScrollView` + `SliverAppBar` / `SliverList` | Um scroll; sem scroll aninhado |
| Conteúdo curto | `ListView` com `children` fixos | OK se poucos filhos |
| Grid de cards | `GridView.builder` ou sliver | Virtualização |

```dart
// ✅ Lista longa — virtualizada
ListView.separated(
  itemCount: state.appointments.length,
  separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
  itemBuilder: (context, index) => AdminAppointmentListCard(
    key: ValueKey(state.appointments[index].id),
    appointmentDetail: state.appointments[index],
  ),
);

// ✅ Seção de formulário — altura mínima, filho direto do ListView
class ServiceFormFieldsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [...],
    );
  }
}
```

### Rebuild e estado

| Anti-padrão | Padrão performático |
|-------------|---------------------|
| `BlocBuilder` na `Page` inteira | `BlocBuilder` por seção com `buildWhen` |
| `_syncControllers()` em `build()` | `BlocListener` ao entrar em edição |
| `setState` na page para cada tecla | `ListenableBuilder` só no preview |
| `buildWhen` omitindo campos visíveis | Incluir todos os campos que a seção exibe |

```dart
BlocBuilder<FinanceCubit, FinanceState>(
  buildWhen: (prev, next) =>
      prev.summary != next.summary || prev.isLoading != next.isLoading,
  builder: (context, state) => FinanceSummarySection(summary: state.summary),
);
```

### Interação + rede

UI **responde na hora**; carga pesada **adiada e cancelável**:

```dart
// Cubit — ver InteractionDebouncer + request id
void onSearchChanged(String query) {
  emit(state.copyWith(searchQuery: query)); // filtro local ou campo imediato
  _searchDebouncer.schedule(() => _loadRemoteResults(query));
}

Future<void> _loadRemoteResults(String query) async {
  final requestId = ++_loadRequestId;
  final results = await _repository.search(query);
  if (requestId != _loadRequestId) return;
  emit(state.copyWith(results: results));
}
```

Referência: `lib/core/utils/interaction_debouncer.dart` · `AdminCalendarCubit`, `SchedulingCubit`, `FinanceCubit`.

### Calendário e keys

```dart
CalendarDatePicker(
  key: ValueKey('${year}-${month}-${calendarRevision}'),
  // não incluir o dia — evita rebuild a cada toque no dia
)
```

### Widgets e const

- `const` em `SizedBox`, padding, ícones e filhos estáticos quando possível
- Extrair cards/seções em widgets próprios — limita escopo de rebuild
- `RepaintBoundary` em blocos pesados (gráficos, calendário grande) se houver jank medido — não por padrão em todo card

### Layout × limitação do Flutter

| Sintoma | Causa | Correção |
|---------|-------|----------|
| Campos somem, só botão aparece | `Row`+`Expanded` sem largura do pai | Seção filha direta do `ListView`; ver form-layout rule |
| Scroll “duro” / aninhado | `ListView` dentro de `SingleChildScrollView` | Um scroll pai; slivers |
| Lista lenta com 200+ itens | `Column` + `map` em scroll | `ListView.builder` |
| Jank ao digitar | Page inteira rebuilda | `ListenableBuilder` / seção isolada |
| Flash de dados antigos | Resposta async obsoleta | `_loadRequestId` no Cubit |

### Imagens e mídia

- Tamanho adequado ao display; cache quando o pacote do projeto já suportar
- Placeholder/skeleton no espaço reservado — evita layout shift (CLS mental no mobile)

## Web

| Cenário | Padrão |
|---------|--------|
| Lista longa | virtualização (`@tanstack/react-virtual`, `react-window`) |
| Busca com API | debounce 250–350 ms; abort `fetch` anterior (`AbortController`) |
| Imagens | `loading="lazy"`, dimensões explícitas, formatos modernos |
| CSS | `content-visibility: auto` em seções abaixo da dobra; evitar `box-shadow` em centenas de nós |
| Layout | um eixo de scroll principal; `sticky` com moderação |
| Hidratação (SSR) | menos estado no primeiro paint; skeleton alinhado ao layout final |

## Heurísticas × performance

| Pedido de UX | Armadilha | Padrão correto |
|--------------|-----------|----------------|
| “Anima tudo” | Jank em listas | `AnimatedContainer` pontual; respeitar `disableAnimations` |
| “Mostra preview ao digitar” | Rebuild global | `ListenableBuilder` no preview |
| “Filtra ao digitar” | Request por tecla | debounce + request id se remoto; filtro local se dados em memória |
| “Dashboard com 20 cards” | 20 queries paralelas | Cubit agrega; UI só renderiza state |
| “Loading na tela inteira” | Percepção lenta | skeleton na seção que carrega; shell estável |

## Anti-padrões

| Evitar | Preferir |
|--------|----------|
| `Column` com `.map` para 50+ itens em scroll | `ListView.builder` |
| `shrinkWrap: true` + `NeverScrollableScrollPhysics` em lista grande | sliver ou builder no scroll pai |
| Dois `BlocBuilder` aninhados na mesma page sem `buildWhen` | seções com escopo de rebuild |
| Debounce em filtro local (lista já carregada) | filtro síncrono no Cubit |
| `Center` → `Column` → `Row(Expanded)` em form | form-layout rule |
| Spinner full-screen para ação de botão | `AppButton(isLoading:)` |
| `opacity` animada em listas inteiras | fade só no item ou skeleton |

## Checklist

### Estrutura
- [ ] Padrão de scroll escolhido (builder / slivers / form ListView)?
- [ ] Formulário segue `Form` → `ListView` sem colapso de largura?
- [ ] Listas longas virtualizadas?

### Rebuild
- [ ] `BlocBuilder` com `buildWhen` onde a page tem várias seções?
- [ ] Preview de formulário com `ListenableBuilder`?
- [ ] Sem efeitos colaterais em `build()`?

### Rede
- [ ] Debounce só onde há query remota pesada?
- [ ] `InteractionDebouncer.dispose()` no `close()` do Cubit?
- [ ] Request id descarta respostas obsoletas?

### Percepção (heurísticas)
- [ ] Loading localizado — shell/cabeçalho permanecem?
- [ ] Interação tátil imediata (seleção de data, tab, chip) antes do fetch?
- [ ] Animações ≤ 300 ms e respeitam preferência do sistema?
