import 'package:adaptable_screen/adaptable_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:quiz_car/core/styles/app_colors.dart';
import 'package:quiz_car/core/styles/app_text_styles.dart';
import 'package:quiz_car/core/utils/strings.dart';

mixin PopUpMixin {
  Future<bool?> popUpConfirmacao() async {
    return await Get.defaultDialog<bool>(
      onWillPop: () async {
        Get.back(result: false);
        return false;
      },
      contentPadding: EdgeInsets.all(10.h),
      title: Strings.atencao,
      textCancel: Strings.nao,
      textConfirm: Strings.sim,
      onConfirm: () => Get.back(result: true),
      confirmTextColor: AppColors.branco,
      cancelTextColor: AppColors.preto,
      buttonColor: AppColors.preto,
      middleText: Strings.menssagemAoSairQuestionario,
    );
  }

  void popUpErro() {
    Future.delayed(const Duration(microseconds: 200)).then((value) {
      Get.defaultDialog(
        contentPadding: EdgeInsets.all(10.h),
        title: "",
        confirmTextColor: AppColors.branco,
        confirm: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            Get.back();
          },
          child: Text(
            Strings.fechar.toUpperCase(),
            style: AppTextStyles.notoSansBold(
              fontSize: 14.ssp,
              color: AppColors.preto,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        middleText: Strings.erroPadrao,
        middleTextStyle: AppTextStyles.notoSansBold(
          fontSize: 17.ssp,
          color: AppColors.cinza,
        ),
      );
    });
  }

  void popUpEmBreve() {
    Get.defaultDialog(
      contentPadding: EdgeInsets.all(10.h),
      title: "",
      confirmTextColor: AppColors.branco,
      confirm: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: () {
          Get.back();
        },
        child: Text(
          Strings.fechar.toUpperCase(),
          style: AppTextStyles.notoSansBold(
            fontSize: 14.ssp,
            color: AppColors.preto,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      middleText: Strings.emBreve,
      middleTextStyle: AppTextStyles.notoSansBold(
        fontSize: 20.ssp,
        color: AppColors.cinza,
      ),
    );
  }
}
