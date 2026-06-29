import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habilitacao_quiz/app/features/resultado/domain/resultado_entity.dart';
import 'package:habilitacao_quiz/core/components/button.dart';
import 'package:habilitacao_quiz/core/mixins/pop_up_mixin.dart';
import 'package:habilitacao_quiz/core/styles/app_styles.dart';
import 'package:habilitacao_quiz/core/styles/spacing_stack.dart';
import 'package:habilitacao_quiz/core/utils/strings.dart';
import 'package:share_plus/share_plus.dart';

class ResultadoScreen extends StatefulWidget {
  const ResultadoScreen({super.key, required this.args});
  final ResultadoEntity args;

  @override
  State<ResultadoScreen> createState() => _ResultadoScreenState();
}

class _ResultadoScreenState extends State<ResultadoScreen> with PopUpMixin {
  bool _isSharing = false;

  String get getPercentual => widget.args.percentual.toPrecision(2).toString();

  Future<void> _onShare() async {
    setState(() => _isSharing = true);
    try {
      await SharePlus.instance.share(
        ShareParams(
          text: Strings.campartilharMensagem(
            titulo: widget.args.titulo,
            percentual: getPercentual,
          ),
        ),
      );
    } catch (_) {
      popUpErro();
    } finally {
      if (mounted) setState(() => _isSharing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            top: AppSpacingStack.xxxLarge.value,
            bottom: AppSpacingStack.xxxSmall.value,
          ),
          child: SizedBox(
            width: double.maxFinite,
            child: Column(
              children: [
                Image.asset(
                  widget.args.result ? AppImages.sucesso : AppImages.bad,
                  height: 300,
                ),
                SizedBox(height: AppSpacingStack.xSmall.value),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSpacingStack.small.value,
                  ),
                  child: Text(
                    widget.args.result
                        ? Strings.parabens
                        : Strings.menssagemBaixoRendimento,
                    style: AppFontStyle.headline20Bold,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: AppSpacingStack.xxxSmall.value),
                Text.rich(
                  TextSpan(
                    text: Strings.voceFinalizou,
                    style: AppFontStyle.body14Regular.setColor(AppColors.grey),
                    children: [
                      TextSpan(
                        text: '${widget.args.titulo}\n',
                        style: AppFontStyle.body14Bold,
                      ),
                      TextSpan(
                        text: Strings.resultadoQuestionario(
                          respostasCorretas: widget.args.totalRespostasCorretas
                              .toString(),
                          totalPerguntas: widget.args.totalPerguntas.toString(),
                          percentual: getPercentual,
                        ),
                        style: AppFontStyle.body14Regular.setColor(
                          AppColors.grey,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: AppSpacingStack.large.value),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSpacingStack.large.value,
                  ),
                  child: AppButton.primary(
                    Strings.compartilhar,
                    expanded: true,
                    onPressed: _isSharing ? null : _onShare,
                  ),
                ),
                SizedBox(height: AppSpacingStack.xxSmall.value),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSpacingStack.large.value,
                  ),
                  child: AppButton.link(
                    Strings.voltarInicio,
                    expanded: true,
                    onPressed: _isSharing ? null : Get.back,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
