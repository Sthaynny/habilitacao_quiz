import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habilitacao_quiz/app/features/routes/routes.dart';
import 'package:habilitacao_quiz/app/shared/domain/services/pro_gate.dart';
import 'package:habilitacao_quiz/core/components/button.dart';
import 'package:habilitacao_quiz/core/constants/government_sources.dart';
import 'package:habilitacao_quiz/core/mixins/pop_up_mixin.dart';
import 'package:habilitacao_quiz/core/styles/app_styles.dart';
import 'package:habilitacao_quiz/core/styles/spacing_stack.dart';
import 'package:habilitacao_quiz/core/utils/strings.dart';
import 'package:habilitacao_quiz/core/utils/url_launcher_helper.dart';

class LegalNoticeScreen extends StatefulWidget {
  const LegalNoticeScreen({super.key});

  @override
  State<LegalNoticeScreen> createState() => _LegalNoticeScreenState();
}

class _LegalNoticeScreenState extends State<LegalNoticeScreen> with PopUpMixin {
  Future<void> _openSource(GovernmentSource source) async {
    final opened = await openExternalUrl(source.url);
    if (!opened && mounted) popUpErro();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Strings.avisoLegal,
          style: AppFontStyle.headline20Bold,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: Get.back,
          tooltip: Strings.voltar,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(AppSpacingStack.xSmall.value),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _DisclaimerCard(),
              SizedBox(height: AppSpacingStack.xSmall.value),
              Text(
                Strings.fontesOficiais,
                style: AppFontStyle.headline20Bold,
              ),
              SizedBox(height: AppSpacingStack.nano.value),
              Text(
                Strings.fontesOficiaisDescricao,
                style: AppFontStyle.body14Regular.setColor(AppColors.grey),
              ),
              SizedBox(height: AppSpacingStack.xSmall.value),
              ...GovernmentSources.list.map(
                (source) => _SourceTile(
                  source: source,
                  onTap: () => _openSource(source),
                ),
              ),
              SizedBox(height: AppSpacingStack.xSmall.value),
              if (Get.find<ProGate>().exibirPromoPlus) ...[
                _PlusLegalTile(
                  onTap: () => Get.toNamed(Routes.habilitacaoQuizPlus),
                ),
                SizedBox(height: AppSpacingStack.xSmall.value),
              ],
              AppButton.primary(
                Strings.voltar,
                expanded: true,
                onPressed: Get.back,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DisclaimerCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSpacingStack.xSmall.value),
      decoration: BoxDecoration(
        color: AppColors.lightPurple.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.info_outline, color: AppColors.purple),
              SizedBox(width: AppSpacingStack.nano.value),
              Text(
                Strings.avisoLegal,
                style: AppFontStyle.body16Bold.setColor(AppColors.purple),
              ),
            ],
          ),
          SizedBox(height: AppSpacingStack.nano.value),
          Text(
            Strings.avisoLegalTexto,
            style: AppFontStyle.body14Regular,
          ),
        ],
      ),
    );
  }
}

class _PlusLegalTile extends StatelessWidget {
  const _PlusLegalTile({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(AppSpacingStack.xSmall.value),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Strings.plusItemLegal,
                style: AppFontStyle.body16Bold,
              ),
              SizedBox(height: AppSpacingStack.quarck.value),
              Text(
                Strings.plusItemLegalDesc,
                style: AppFontStyle.body14Regular.setColor(AppColors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SourceTile extends StatelessWidget {
  const _SourceTile({
    required this.source,
    required this.onTap,
  });

  final GovernmentSource source;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppSpacingStack.nano.value),
      child: Material(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(AppSpacingStack.xSmall.value),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  source.title,
                  style: AppFontStyle.body16Bold,
                ),
                SizedBox(height: AppSpacingStack.quarck.value),
                Text(
                  source.description,
                  style: AppFontStyle.body14Regular.setColor(AppColors.grey),
                ),
                SizedBox(height: AppSpacingStack.nano.value),
                Text(
                  source.url,
                  style: AppFontStyle.body14Regular.setColor(AppColors.blue),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
