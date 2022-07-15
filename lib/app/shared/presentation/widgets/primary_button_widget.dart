import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habilitacao_quiz/core/styles/app_colors.dart';

class PrimaryButtonWidget extends StatelessWidget {
  const PrimaryButtonWidget({
    Key? key,
    required this.label,
    required this.backgoundColor,
    required this.fontColor,
    required this.borderColor,
    this.onTap,
  }) : super(key: key);

  const PrimaryButtonWidget.branco({
    required this.label,
    this.onTap,
    Key? key,
  })  : backgoundColor = AppColors.branco,
        fontColor = AppColors.cinza,
        borderColor = AppColors.border,
        super(key: key);

  const PrimaryButtonWidget.azul({
    required this.label,
    this.onTap,
    Key? key,
  })  : backgoundColor = AppColors.azul,
        fontColor = onTap != null ? AppColors.branco : AppColors.cinza,
        borderColor = AppColors.border,
        super(key: key);

  const PrimaryButtonWidget.transparente({
    required this.label,
    this.onTap,
    Key? key,
  })  : backgoundColor = AppColors.branco,
        fontColor = AppColors.cinza,
        borderColor = AppColors.border,
        super(key: key);

  final String label;
  final Color backgoundColor;
  final Color fontColor;
  final Color borderColor;
  final VoidCallback? onTap;

  BorderRadius get borderRadius => BorderRadius.circular(10);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        border: Border.all(
          color: borderColor,
        ),
        borderRadius: borderRadius,
      ),
      width: double.maxFinite,
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        color: backgoundColor,
        borderRadius: borderRadius,
        onPressed: onTap,
        child: Text(
          label,
          style: GoogleFonts.notoSans(
            fontWeight: FontWeight.w600,
            fontSize: 15,
            color: fontColor,
          ),
        ),
      ),
    );
  }
}
