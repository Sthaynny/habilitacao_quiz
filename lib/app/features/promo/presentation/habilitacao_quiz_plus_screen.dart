import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habilitacao_quiz/app/shared/domain/services/pro_gate.dart';
import 'package:habilitacao_quiz/core/components/button.dart';
import 'package:habilitacao_quiz/core/constants/app_store_constants.dart';
import 'package:habilitacao_quiz/core/edition/app_edition.dart';
import 'package:habilitacao_quiz/core/store/app_store_launcher.dart';
import 'package:habilitacao_quiz/core/styles/app_styles.dart';
import 'package:habilitacao_quiz/core/styles/spacing_stack.dart';
import 'package:habilitacao_quiz/core/utils/strings.dart';

class HabilitacaoQuizPlusScreen extends StatelessWidget {
  const HabilitacaoQuizPlusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (kIsPro) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (Get.key.currentState?.canPop() ?? false) {
          Get.back();
        }
      });
      return const Scaffold(body: SizedBox.shrink());
    }

    final proGate = Get.find<ProGate>();
    if (!proGate.exibirPromoPlus) {
      return const Scaffold(body: SizedBox.shrink());
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStoreConstants.plusProductName,
          style: AppFontStyle.headline20Bold,
        ),
        leading: IconButton(
          icon: const Icon(Icons.close),
          tooltip: Strings.fechar,
          onPressed: Get.back,
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.all(AppSpacingStack.xSmall.value),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: constraints.maxWidth > 600 ? 560 : double.infinity,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        Strings.plusScreenTitle,
                        style: AppFontStyle.headline24Bold,
                      ),
                      SizedBox(height: AppSpacingStack.xxxSmall.value),
                      Text(
                        Strings.plusScreenIntro,
                        style: AppFontStyle.body14Regular
                            .setColor(AppColors.grey),
                      ),
                      SizedBox(height: AppSpacingStack.small.value),
                      ...Strings.plusBenefits.map(
                        (benefit) => Padding(
                          padding: EdgeInsets.only(
                            bottom: AppSpacingStack.nano.value,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.check_circle_outline,
                                color: AppColors.green,
                                size: 22,
                              ),
                              SizedBox(width: AppSpacingStack.nano.value),
                              Expanded(
                                child: Text(
                                  benefit,
                                  style: AppFontStyle.body14Regular,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: AppSpacingStack.large.value),
                      AppButton.primary(
                        AppStoreConstants.isProPublished
                            ? Strings.plusVerNaLoja
                            : Strings.plusEmBreve,
                        expanded: true,
                        onPressed: () => openHabilitacaoQuizPlusStore(useUtm: true),
                      ),
                      SizedBox(height: AppSpacingStack.xxSmall.value),
                      AppButton.link(
                        Strings.voltar,
                        expanded: true,
                        onPressed: Get.back,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
