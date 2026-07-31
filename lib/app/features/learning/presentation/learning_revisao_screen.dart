import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habilitacao_quiz/app/features/learning/domain/services/revisao_quiz_builder.dart';
import 'package:habilitacao_quiz/app/features/learning/domain/usecases/learning_usecases.dart';
import 'package:habilitacao_quiz/app/features/learning/domain/usecases/revisar_erros_ultimo_teste_usecase.dart';
import 'package:habilitacao_quiz/app/features/learning/presentation/widgets/learning_promo_link.dart';
import 'package:habilitacao_quiz/app/features/routes/routes.dart';
import 'package:habilitacao_quiz/app/shared/domain/services/pro_gate.dart';
import 'package:habilitacao_quiz/core/components/button.dart';
import 'package:habilitacao_quiz/core/components/section_header_a11y.dart';
import 'package:habilitacao_quiz/core/styles/app_styles.dart';
import 'package:habilitacao_quiz/core/styles/spacing_stack.dart';
import 'package:habilitacao_quiz/core/utils/strings.dart';

class LearningRevisaoScreen extends StatefulWidget {
  const LearningRevisaoScreen({super.key});

  @override
  State<LearningRevisaoScreen> createState() => _LearningRevisaoScreenState();
}

class _LearningRevisaoScreenState extends State<LearningRevisaoScreen> {
  List<String> _ids = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final ids = await Get.find<GetRevisaoEspacadaIdsUsecase>()();
    if (!mounted) return;
    setState(() {
      _ids = ids;
      _loading = false;
    });
  }

  Future<void> _iniciarRevisaoEspacada() async {
    final quiz =
        await Get.find<RevisaoQuizBuilder>().buildFromQuestionIds(_ids);
    if (quiz == null) {
      Get.snackbar(Strings.atencao, Strings.revisaoEspacadaVazia);
      return;
    }
    Get.toNamed(Routes.questionario, arguments: quiz);
  }

  Future<void> _revisarErrosUltimo() async {
    final quiz = await Get.find<RevisarErrosUltimoTesteUsecase>()();
    if (quiz == null) {
      Get.snackbar(Strings.atencao, Strings.revisaoEspacadaVazia);
      return;
    }
    Get.toNamed(Routes.questionario, arguments: quiz);
  }

  @override
  Widget build(BuildContext context) {
    final proGate = Get.find<ProGate>();
    if (!proGate.podeRevisaoEspacada) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            Strings.revisaoEspacada,
            style: AppFontStyle.headline20Bold,
          ),
        ),
        body: Center(
          child: LearningPromoLink(
            onPressed: () => Get.toNamed(Routes.habilitacaoQuizPlus),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          Strings.revisaoEspacada,
          style: AppFontStyle.headline20Bold,
        ),
      ),
      body: _loading
          ? Semantics(
              label: 'Carregando revisão espaçada',
              child: const Center(child: CircularProgressIndicator()),
            )
          : Padding(
              padding: EdgeInsets.all(AppSpacingStack.xxxSmall.value),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SectionHeaderA11y(
                    title: Strings.revisaoEspacada,
                    subtitle: Strings.revisaoEspacadaDescricao,
                  ),
                  SizedBox(height: AppSpacingStack.xxxSmall.value),
                  Semantics(
                    label: Strings.revisaoEspacadaPendentes(_ids.length),
                    child: Text(
                      Strings.revisaoEspacadaPendentes(_ids.length),
                      style:
                          AppFontStyle.body14Regular.setColor(AppColors.grey),
                    ),
                  ),
                  SizedBox(height: AppSpacingStack.xxxSmall.value),
                  AppButton.primary(
                    Strings.revisaoEspacadaIniciar,
                    onPressed: _ids.isEmpty ? null : _iniciarRevisaoEspacada,
                  ),
                  SizedBox(height: AppSpacingStack.quarck.value),
                  if (proGate.podeRevisarErrosUltimoTeste)
                    AppButton.secundary(
                      Strings.revisarErrosUltimoTeste,
                      onPressed: _revisarErrosUltimo,
                    ),
                ],
              ),
            ),
    );
  }
}
