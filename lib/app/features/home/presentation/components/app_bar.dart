import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  static const double _contentHeight = 180;

  static double _toolbarHeight(double topInset) => _contentHeight + topInset;

  static int _logoCachePx(BuildContext context) {
    return (90 * MediaQuery.devicePixelRatioOf(context)).round();
  }

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.paddingOf(context).top;
    final toolbarHeight = _toolbarHeight(topInset);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          SizedBox(height: toolbarHeight),
          Positioned(
            top: -_gradientTopLift,
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
                Image.asset(
                  AppImages.logo,
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                  cacheWidth: _logoCachePx(context),
                  cacheHeight: _logoCachePx(context),
                  excludeFromSemantics: true,
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
