# Área de Aprendizado

**Épico:** [LEARN]  
**Onda:** 3 (após gate + loja Pro estáveis)

## Job-to-be-done

**Quando** estudo para a CNH, **quero** saber *o que* e *em que ordem* estudar antes de só responder questões, **para** reduzir ansiedade e usar o tempo com intenção — sem confundir o app com material oficial DETRAN.

## Navegação proposta

**3ª aba no bottom nav:** `Aprender` · `Quizzes` · `Histórico`

```
Aprender
 ├─ Hub (5 temas = QuizEnum)
 ├─ Tema → resumo + artigo + "Praticar tema"
 ├─ Trilha básica (Free) / completa (Pro)
 ├─ Fontes oficiais (reuso legal_notice)
 └─ Pro: fichas, mapa de competências, revisão espaçada (fase C)
```

Rotas sugeridas: `/aprender`, `/aprender/tema/:id`, `/aprender/trilha`, `/aprender/ficha/:id`, `/aprender/mapa`.

## Conteúdo

### MVP (assets offline)

```
assets/learning/
  manifest.json
  trilha_basica.json
  temas/<tema>/resumo.md, artigo_01.md
```

| Entregável | Free | Pro |
| :--- | :---: | :---: |
| 5 resumos curtos | ✅ | ✅ |
| 1 artigo/tema | ✅ | ✅ |
| Trilha básica | ✅ | ✅ |
| Trilha completa | preview + CTA | ✅ |
| Fichas (placas, socorros…) | amostra | ✅ |
| Mapa % por matéria | estático | dinâmico (histórico) |
| Revisão espaçada | ❌ | ✅ (precisa ID questão no JSON) |

Disclaimer em todo hub (mesmo espírito de `Strings.avisoLegalTexto`).

## Integração

- `themeId` ↔ `QuizEnum` ↔ pasta de conteúdo
- CTA “Praticar” → fluxo questionário existente (`ProGate` no tamanho da sessão)
- Progresso trilha em `SharedPreferences` (separado do histórico de notas)
- Mapa Pro agrega histórico por tema (depende P04 estatísticas)

## Riscos

| Risco | Mitigação |
| :--- | :--- |
| Resumo desatualizado vs CTB | Links Planalto; `contentVersion`; evitar números de multa sem data |
| Parecer material DETRAN | Disclaimer; sem logos gov. |
| Resumo ≠ questões JSON | Revisar conteúdo junto com patches em `assets/json/` |

## Mapa `themeId` ↔ `QuizEnum` (HQ-A01)

| `themeId` (pasta / manifest) | `QuizEnum` (código) | Título UI (`Strings`) |
| :--- | :--- | :--- |
| `legislacao` | `QuizEnum.legislacao` | Legislação |
| `direcao_defensiva` | `QuizEnum.direcaoDefensiva` | Direção defensiva |
| `mecanica_basica` | `QuizEnum.mecanicaBasica` | Mecânica básica |
| `primeiros_socorros` | `QuizEnum.primeirosSocorros` | Primeiros socorros |
| `meio_ambiente` | `QuizEnum.meioAmbiente` | Meio ambiente |

`QuizEnum.simulado` não possui pasta em `assets/learning/` — simulado permanece só na aba Quizzes.

Implementação: `LearningThemeId` + `QuizEnumLearningX` em `lib/app/features/learning/domain/learning_theme_id.dart`.

## Tarefas HQ-A01 … HQ-A15

Ver [A_FAZER.md](../tasks/A_FAZER.md#aprender--hq-a).
