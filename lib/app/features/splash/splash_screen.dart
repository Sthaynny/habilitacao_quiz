import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habilitacao_quiz/app/features/historico/domain/entities/historico_entity.dart';
import 'package:habilitacao_quiz/app/features/historico/domain/usecases/get_historico_usecase.dart';
import 'package:habilitacao_quiz/app/features/routes/routes.dart';
import 'package:habilitacao_quiz/core/components/circular_progress_widget.dart';
import 'package:habilitacao_quiz/core/styles/app_styles.dart';
import 'package:habilitacao_quiz/core/styles/spacing_stack.dart';
import 'package:habilitacao_quiz/core/utils/strings.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  static const _splashDuration = Duration(seconds: 2);
  static const _historicoTimeout = Duration(seconds: 5);

  @override
  void initState() {
    super.initState();
    _loadAndNavigate();
  }

  Future<void> _loadAndNavigate() async {
    final historicoFuture = _loadHistorico();
    await Future.wait([
      historicoFuture,
      Future<void>.delayed(_splashDuration),
    ]);
    if (!mounted) return;
    final historico = await historicoFuture;
    Get.put<HistoricoEntity>(historico, permanent: true);
    Get.offAndToNamed(Routes.home);
  }

  Future<HistoricoEntity> _loadHistorico() async {
    try {
      return await Get.find<GetHistoricoUsecase>()
          .call()
          .timeout(_historicoTimeout);
    } catch (_) {
      return HistoricoEntity(resutados: []);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppGradients.linear,
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Semantics(
                label: Strings.logoApp.replaceAll('\n', ' '),
                image: true,
                child: Image.asset(AppImages.splash),
              ),
              SizedBox(height: AppSpacingStack.xxSmall.value),
              Semantics(
                label: 'Carregando',
                liveRegion: true,
                child: const CircularProgressWidget(
                  primaryColor: AppColors.white,
                  secondaryColor: AppColors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
