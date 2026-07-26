import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habilitacao_quiz/app/features/routes/routes.dart';
import 'package:habilitacao_quiz/core/styles/app_colors.dart';
import 'package:habilitacao_quiz/core/styles/app_font_styles.dart';
import 'package:habilitacao_quiz/core/styles/app_gradients.dart';
import 'package:habilitacao_quiz/core/styles/app_images.dart';
import 'package:habilitacao_quiz/core/styles/spacing_stack.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.paddingOf(context).top;

    return Stack(
      children: [
        Container(height: 180 + topInset),
        Positioned(
          top: -20,
          child: Container(
            height: 190,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.symmetric(
              horizontal: AppSpacingStack.xxSmall.value,
              vertical: AppSpacingStack.xxxSmall.value,
            ),
            decoration: BoxDecoration(
              gradient: AppGradients.linear,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Semantics(
                    header: true,
                    child: Text.rich(
                      TextSpan(
                        text: 'Habilitação Quiz',
                        style: AppFontStyle.headline24Bold.setColor(
                          AppColors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.info_outline, color: AppColors.white),
                  tooltip: 'Aviso legal',
                  onPressed: () => Get.toNamed(Routes.legalNotice),
                ),
                Container(
                  height: 90,
                  width: 90,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppImages.logo),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize {
    final topInset = MediaQueryData.fromView(
      WidgetsBinding.instance.platformDispatcher.views.first,
    ).padding.top;
    return Size.fromHeight(180 + topInset);
  }
}
