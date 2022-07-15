import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habilitacao_quiz/core/styles/app_colors.dart';
import 'package:habilitacao_quiz/core/styles/app_gradients.dart';
import 'package:habilitacao_quiz/core/styles/app_images.dart';
import 'package:habilitacao_quiz/core/styles/app_text_styles.dart';
import 'package:habilitacao_quiz/core/styles/spacing_stack.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 180,
        ),
        Positioned(
          top: -20,
          child: Container(
            height: 190,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.symmetric(
                horizontal: AppSpacingStack.xxSmall.value,
                vertical: AppSpacingStack.xxxSmall.value),
            decoration: BoxDecoration(
              gradient: AppGradients.linear,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(
                    text: 'Habilitação Quiz',
                    style: AppFontStyle.headline24Bold.setColor(
                      AppColors.white,
                    ),
                  ),
                ),
                Container(
                  height: 90,
                  width: 90,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        AppImages.logo,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(180);
}
