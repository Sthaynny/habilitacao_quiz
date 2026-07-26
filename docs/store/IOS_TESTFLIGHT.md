# iOS — Bundle Pro e TestFlight

**Pré-requisito:** conta Apple Developer ativa (T20).

## Identificadores

| Edição | Bundle ID alvo |
| :--- | :--- |
| Free | `br.com.sthaynny.habilitacaoQuiz` (atual no Xcode) |
| Pro | `br.com.sthaynny.habilitacao_quiz.pro` |

Arquivo de referência para build Pro: `ios/Flutter/EditionPro.xcconfig`.

## Configurar scheme Pro no Xcode (uma vez)

1. Abrir `ios/Runner.xcworkspace` no Xcode.
2. **Runner** → **Build Settings** → duplicar configurações Debug/Release como `Debug-pro` / `Release-pro` (ou usar xcconfig).
3. Em `Release-pro`, definir `PRODUCT_BUNDLE_IDENTIFIER` = `br.com.sthaynny.habilitacao_quiz.pro`.
4. **CFBundleDisplayName** = `Habilitação Quiz+` (Info.plist ou build setting `INFOPLIST_KEY_CFBundleDisplayName`).
5. Duplicar scheme **Runner** → **Runner Pro**; em Run/Archive, usar `Release-pro`.
6. No [App Store Connect](https://appstoreconnect.apple.com), criar app **Habilitação Quiz+** com o bundle `.pro`.

## Build Flutter (Pro)

```bash
flutter build ipa \
  --dart-define=HABILITACAO_QUIZ_PRO=true \
  --export-options-plist=ios/ExportOptions.plist
```

Ajuste flags do `flutter build ipa` conforme scheme criado (pode ser necessário `--flavor` se configurado no projeto).

## TestFlight

1. Archive no Xcode (scheme **Runner Pro**) ou IPA via CI.
2. Upload com **Transporter** ou `xcrun altool`.
3. Em App Store Connect → TestFlight → adicionar grupo interno.
4. Validar: sem CTAs do **+**, simulado 30q, histórico ilimitado.

## Enquanto a conta Apple não estiver ativa

- Manter este guia e `EditionPro.xcconfig` no repositório.
- Publicar apenas Android até conta e certificados iOS estarem prontos.
