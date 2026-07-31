import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habilitacao_quiz/app/features/promo/presentation/widgets/habilitacao_quiz_plus_cta_banner.dart';
import 'package:habilitacao_quiz/app/features/resultado/domain/resultado_entity.dart';
import 'package:habilitacao_quiz/app/features/resultado/domain/should_show_resultado_simulado_plus_cta.dart';
import 'package:habilitacao_quiz/app/features/routes/routes.dart';
import 'package:habilitacao_quiz/app/shared/domain/services/pro_gate.dart';
import 'package:habilitacao_quiz/core/analytics/promo_funnel_analytics.dart';
import 'package:habilitacao_quiz/core/components/button.dart';
import 'package:habilitacao_quiz/core/mixins/pop_up_mixin.dart';
import 'package:habilitacao_quiz/core/styles/app_styles.dart';
import 'package:habilitacao_quiz/core/styles/spacing_stack.dart';
import 'package:habilitacao_quiz/core/utils/strings.dart';
import 'package:share_plus/share_plus.dart';

class ResultadoScreen extends StatelessWidget {
  const ResultadoScreen({super.key, required this.args});

  final ResultadoEntity args;

  @override
  Widget build(BuildContext context) {
    final percentual = args.percentual.toPrecision(2).toString();
    final summaryLabel = Strings.resultadoQuestionario(
      respostasCorretas: args.totalRespostasCorretas.toString(),
      totalPerguntas: args.totalPerguntas.toString(),
      percentual: percentual,
    );
    final headline =
        args.result ? Strings.parabens : Strings.menssagemBaixoRendimento;
    final showSimuladoPlusCta = shouldShowResultadoSimuladoPlusCta(
      resultado: args,
      proGate: Get.find<ProGate>(),
    );

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
                ExcludeSemantics(
                  child: Image.asset(
                    args.result ? AppImages.sucesso : AppImages.bad,
                    height: 300,
                  ),
                ),
                SizedBox(height: AppSpacingStack.xSmall.value),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSpacingStack.small.value,
                  ),
                  child: Semantics(
                    header: true,
                    liveRegion: true,
                    child: Text(
                      headline,
                      style: AppFontStyle.headline20Bold,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(height: AppSpacingStack.xxxSmall.value),
                Semantics(
                  label: '${args.titulo}. $summaryLabel',
                  child: ExcludeSemantics(
                    child: Text.rich(
                      TextSpan(
                        text: Strings.voceFinalizou,
                        style:
                            AppFontStyle.body14Regular.setColor(AppColors.grey),
                        children: [
                          TextSpan(
                            text: '${args.titulo}\n',
                            style: AppFontStyle.body14Bold,
                          ),
                          TextSpan(
                            text: summaryLabel,
                            style: AppFontStyle.body14Regular.setColor(
                              AppColors.grey,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                if (showSimuladoPlusCta) ...[
                  SizedBox(height: AppSpacingStack.xSmall.value),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSpacingStack.large.value,
                    ),
                    child: Semantics(
                      header: true,
                      child: Text(
                        Strings.resultadoSimuladoFreeCta,
                        style: AppFontStyle.body14Regular
                            .setColor(AppColors.grey),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(height: AppSpacingStack.nano.value),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSpacingStack.xxxSmall.value,
                    ),
                    child: HabilitacaoQuizPlusCtaBanner(
                      compact: false,
                      analyticsSurface: PromoSurface.resultadoSimulado,
                      onTap: () => Get.toNamed(Routes.habilitacaoQuizPlus),
                    ),
                  ),
                ],
                SizedBox(height: AppSpacingStack.large.value),
                _ResultadoShareActions(
                  titulo: args.titulo,
                  percentual: percentual,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ResultadoShareActions extends StatefulWidget {
  const _ResultadoShareActions({
    required this.titulo,
    required this.percentual,
  });

  final String titulo;
  final String percentual;

  @override
  State<_ResultadoShareActions> createState() => _ResultadoShareActionsState();
}

class _ResultadoShareActionsState extends State<_ResultadoShareActions>
    with PopUpMixin {
  bool _isSharing = false;

  Future<void> _onShare() async {
    setState(() => _isSharing = true);
    try {
      await SharePlus.instance.share(
        ShareParams(
          text: Strings.campartilharMensagem(
            titulo: widget.titulo,
            percentual: widget.percentual,
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
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
    );
  }
}
