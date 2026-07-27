# Builds Free e Pro — Habilitação Quiz

Dois binários a partir do mesmo repositório Flutter, alinhados a [modelo-free-pro.md](../features/modelo-free-pro.md).

## Flags de compilação

| Flag | Free | Pro |
| :--- | :--- | :--- |
| `HABILITACAO_QUIZ_PRO` | omitir ou `false` | `true` |
| `HABILITACAO_QUIZ_PRO_PUBLISHED` | `true` (CTAs abrem a Play do **+**) | não se aplica |

Edição e nome exibido: `lib/core/edition/app_edition.dart` (`kIsPro`, `kAppDisplayName`).

## Android (flavors)

| Flavor | Application ID | Nome no launcher |
| :--- | :--- | :--- |
| `free` | `br.com.sthaynny.habilitacao_quiz` | Habilitação Quiz |
| `pro` | `br.com.sthaynny.habilitacao_quiz.pro` | Habilitação Quiz+ |

Assinatura release: `android/key.properties` (não versionado).

### Comandos

```bash
flutter pub get

# AAB Free (loja gratuita)
flutter build appbundle --flavor free \
  --dart-define=HABILITACAO_QUIZ_PRO_PUBLISHED=true

# AAB Pro (compra única)
flutter build appbundle --flavor pro \
  --dart-define=HABILITACAO_QUIZ_PRO=true

# APK local (debug / smoke)
flutter build apk --flavor free --debug
flutter build apk --flavor pro --debug \
  --dart-define=HABILITACAO_QUIZ_PRO=true
```

Saídas típicas:

- `build/app/outputs/bundle/freeRelease/app-free-release.aab`
- `build/app/outputs/bundle/proRelease/app-pro-release.aab`

## iOS

Bundle Free atual: `br.com.sthaynny.habilitacaoQuiz` (Xcode). Bundle Pro alvo: `br.com.sthaynny.habilitacao_quiz.pro` — ver [IOS_TESTFLIGHT.md](./IOS_TESTFLIGHT.md).

Build Pro (após configurar scheme no Xcode):

```bash
flutter build ipa --dart-define=HABILITACAO_QUIZ_PRO=true
```

## Verificação rápida

```bash
flutter analyze
flutter test test/shared/domain/services/pro_gate_test.dart
flutter test test/shared/utils/simulado_test.dart
flutter test test/features/historico/domain/entities/historico_entity_test.dart
```

Checklist manual: [SMOKE_PRO.md](./SMOKE_PRO.md).

## VS Code / Cursor (debug)

Perfis em [.vscode/launch.json](../../.vscode/launch.json):

| Configuração | Uso |
| :--- | :--- |
| **Free (Android)** | `--flavor free` |
| **Free (Android) · loja + publicada** | Free + `HABILITACAO_QUIZ_PRO_PUBLISHED=true` (CTA abre a Play do **+**) |
| **Pro (Android)** | `--flavor pro` + `HABILITACAO_QUIZ_PRO=true` |
| **Pro (iOS / sem flavor)** | Só `HABILITACAO_QUIZ_PRO=true` (iOS ainda sem flavor no Gradle) |
| **Dart: Run all Tests** | `test/` inteiro |

Após trocar plugins nativos (`file_picker`, `share_plus`, etc.), rode `flutter clean && flutter pub get` antes do próximo run.

## Dependências nativas (Android)

- **AGP 8+** (ver `android/settings.gradle`) exige `namespace` nos plugins; `file_picker` &lt; 8 quebra o Gradle.
- **file_picker** ^11 (última **estável**; 12.x é só beta) e **share_plus** ^12 resolvem o grafo `win32` no host Windows (dev). Não usar `dependency_overrides` em `win32`.
- Subir **share_plus** para ^13 quando **file_picker** publicar release estável com `win32` ^6.
