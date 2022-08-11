import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:habilitacao_quiz/core/components/button.dart';
import 'package:habilitacao_quiz/core/styles/app_colors.dart';
import 'package:habilitacao_quiz/core/styles/app_font_styles.dart';
import 'package:habilitacao_quiz/core/styles/spacing_stack.dart';
import 'package:habilitacao_quiz/core/utils/strings.dart';

mixin PopUpMixin {
  Future<bool?> popUpConfirmacao() async {
    return await Get.defaultDialog<bool>(
      contentPadding: EdgeInsets.all(AppSpacingStack.nano.value),
      title: Strings.atencao,
      titleStyle: AppFontStyle.headline20Bold,
      // textCancel: Strings.nao,
      // textConfirm: Strings.sim,
      // onConfirm: () => Get.back(result: true),
      // confirmTextColor: AppColors.branco,
      // cancelTextColor: AppColors.preto,
      // buttonColor: AppColors.primary,
      middleText: Strings.menssagemAoSairQuestionario,
      middleTextStyle: AppFontStyle.body16Regular,
      cancel: SizedBox(
        width: 60,
        child: AppButton.primaryOutline(
          Strings.nao,
          onPressed: Get.back,
        ),
      ),
      confirm: SizedBox(
        width: 60,
        child: AppButton.primary(
          Strings.sim,
          onPressed: () => Get.back(result: true),
        ),
      ),
    );
  }

  void popUpErro() {
    Future.delayed(const Duration(microseconds: 200)).then((value) {
      Get.defaultDialog(
          contentPadding: EdgeInsets.all(AppSpacingStack.nano.value),
          title: "",
          confirmTextColor: AppColors.branco,
          confirm: CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              Get.back();
            },
            child: Text(
              Strings.fechar.toUpperCase(),
              style: AppFontStyle.body14Regular,
              textAlign: TextAlign.center,
            ),
          ),
          middleText: Strings.erroPadrao,
          middleTextStyle: AppFontStyle.button16Bold);
    });
  }

  void popUpEmBreve() {
    Get.defaultDialog(
        contentPadding: EdgeInsets.all(AppSpacingStack.nano.value),
        title: "",
        confirmTextColor: AppColors.branco,
        confirm: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            Get.back();
          },
          child: Text(
            Strings.fechar.toUpperCase(),
            style: AppFontStyle.body14Bold,
            textAlign: TextAlign.center,
          ),
        ),
        middleText: Strings.emBreve,
        middleTextStyle: AppFontStyle.headline20Bold);
  }
}
