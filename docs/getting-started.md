# Começando — Habilitação Quiz

Guia rápido para rodar o app e achar o restante da documentação. Tempo alvo: menos de 30 minutos com Flutter já instalado.

## Pré-requisitos

- [Flutter SDK](https://docs.flutter.dev/get-started/install) estável compatível com o `pubspec.yaml` do repositório
- Android: SDK + emulador ou dispositivo; para release, `android/key.properties` (não versionado)
- iOS (opcional): Xcode e conta Apple Developer para TestFlight — ver [store/IOS_TESTFLIGHT.md](./store/IOS_TESTFLIGHT.md)

## Rodar em desenvolvimento

```bash
git clone https://github.com/Sthaynny/habilitacao_quiz.git
cd habilitacao_quiz
flutter pub get
flutter run
```

O comando padrão costuma refletir a edição configurada no projeto. Para **Free** e **Pro** com flavors Android, perfis de debug e comandos de release, use [store/BUILD.md](./store/BUILD.md).

## Qualidade local

```bash
flutter analyze
flutter test
```

Antes de abrir PR, siga o hook `pre-commit` descrito no [README](../README.md#-contribuição).

## Mapa da documentação

| Objetivo | Onde ler |
| :--- | :--- |
| Índice completo | [README.md](./README.md) |
| Produto Free / **+** | [product/PRODUCT_PLAN.md](./product/PRODUCT_PLAN.md) |
| Implementar um épico | [features/](./features/README.md) + [tasks/A_FAZER.md](./tasks/A_FAZER.md) |
| Arquitetura e DS | [engineering/](./engineering/README.md) |
| Agentes Cursor | [AGENTS.md](../AGENTS.md) |
| Publicar na loja | [store/](./store/README.md) |

## Contribuir

Fluxo git e convenções de commit para humanos e agentes: [engineering/git-commit-protocol.md](./engineering/git-commit-protocol.md) e [.github/contributing.md](../.github/contributing.md).
