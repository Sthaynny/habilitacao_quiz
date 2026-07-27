import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habilitacao_quiz/app/features/routes/routes.dart';
import 'package:habilitacao_quiz/core/edition/app_edition.dart';
import 'package:habilitacao_quiz/core/styles/app_colors.dart';
import 'package:habilitacao_quiz/core/styles/app_font_styles.dart';
import 'package:habilitacao_quiz/core/styles/app_gradients.dart';
import 'package:habilitacao_quiz/core/styles/app_images.dart';
import 'package:habilitacao_quiz/core/styles/spacing_stack.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({super.key});

  static const double _gradientHeight = 190;
  static const double _gradientTopLift = 20;

  static double _toolbarHeight(double topInset) =>
      topInset + _gradientHeight - _gradientTopLift;

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.paddingOf(context).top;
    final toolbarHeight = _toolbarHeight(topInset);

    return SizedBox(
      height: toolbarHeight,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: topInset - _gradientTopLift,
            left: 0,
            right: 0,
            child: Container(
              height: _gradientHeight,
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
                        text: kAppDisplayName,
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
      ),
    );
  }

  @override
  Size get preferredSize {
    final topInset = MediaQueryData.fromView(
      WidgetsBinding.instance.platformDispatcher.views.first,
    ).padding.top;
    return Size.fromHeight(_toolbarHeight(topInset));
  }
}
