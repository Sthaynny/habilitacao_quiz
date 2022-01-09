import 'package:adaptable_screen/adaptable_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_car/core/styles/app_colors.dart';

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
        fontColor = AppColors.branco,
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

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48.h,
      width: double.maxFinite,
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            backgoundColor,
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
          side: MaterialStateProperty.all(
            BorderSide(color: borderColor),
          ),
        ),
        onPressed: onTap,
        child: Text(
          label,
          style: GoogleFonts.notoSans(
            fontWeight: FontWeight.w600,
            fontSize: 15.ssp,
            color: fontColor,
          ),
        ),
      ),
    );
  }
}
