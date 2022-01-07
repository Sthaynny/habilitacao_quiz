import 'package:adaptable_screen/adaptable_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_car/core/styles/app_colors.dart';
import 'package:quiz_car/core/styles/app_text_styles.dart';

mixin EmBreve {
  void bottomSheetEmBreve(BuildContext context) {
    showDialog(
        context: context,
        useSafeArea: true,
        builder: (context) {
          return Center(
            child: Container(
              width: 200.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.h,
                      vertical: 20.w,
                    ),
                    child: Text(
                      'Em breve!',
                      style: AppTextStyles.notoSansBold(
                        fontSize: 17.ssp,
                        color: AppColors.preto,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Divider(),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'fechar'.toUpperCase(),
                      style: AppTextStyles.notoSansBold(
                        fontSize: 14.ssp,
                        color: AppColors.preto,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
