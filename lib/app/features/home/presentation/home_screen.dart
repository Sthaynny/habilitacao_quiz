import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habilitacao_quiz/app/features/learning/presentation/widgets/learning_hub_widget.dart';
import 'package:habilitacao_quiz/app/features/historico/presentation/historico_widget.dart';
import 'package:habilitacao_quiz/app/features/home/presentation/components/app_bar.dart';
import 'package:habilitacao_quiz/app/features/home/presentation/components/bottom_nav_bar.dart';
import 'package:habilitacao_quiz/app/features/home/presentation/components/quizzes/controller/quizzes_controller.dart';
import 'package:habilitacao_quiz/app/features/home/presentation/components/quizzes/quizzes_widget.dart';
import 'package:habilitacao_quiz/app/features/home/presentation/controller/home_controller.dart';
import 'package:habilitacao_quiz/app/features/promo/presentation/widgets/habilitacao_quiz_plus_cta_banner.dart';
import 'package:habilitacao_quiz/app/features/onboarding/presentation/onboarding_materia_sheet.dart';
import 'package:habilitacao_quiz/app/features/study_reminder/domain/study_reminder_service.dart';
import 'package:habilitacao_quiz/app/features/study_reminder/presentation/study_reminder_prompt_sheet.dart';
import 'package:habilitacao_quiz/app/shared/domain/services/quiz_content_version_service.dart';
import 'package:habilitacao_quiz/app/shared/domain/services/pro_gate.dart';
import 'package:habilitacao_quiz/app/shared/presentation/pages/loading_blur_screen.dart';
import 'package:habilitacao_quiz/core/mixins/pop_up_mixin.dart';
import 'package:habilitacao_quiz/core/styles/app_styles.dart';
import 'package:habilitacao_quiz/core/utils/quiz_content_updated_feedback.dart';
import 'package:habilitacao_quiz/core/utils/strings.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.controller,
    required this.quizzesController,
  });
  final HomeController controller;
  final QuizzesController quizzesController;

  @override
  createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> with PopUpMixin {
  HomeController get controller => widget.controller;
  late final QuizzesController quizzesController;
  final PageController pageController = PageController();
  Worker? _statusWorker;
  late final List<BottomNavyBarItem> _bottomNavItems;

  @override
  void initState() {
    quizzesController = widget.quizzesController;
    _bottomNavItems = [
      BottomNavyBarItem(
        icon: const Icon(Icons.home),
        title: Text(
          Strings.quizzes,
          style: AppFontStyle.body14Regular,
        ),
        textAlign: TextAlign.center,
        activeColor: AppColors.purple,
        inactiveColor: AppColors.grey,
      ),
      BottomNavyBarItem(
        icon: const Icon(Icons.menu_book_outlined),
        title: Text(
          Strings.aprender,
          style: AppFontStyle.body14Regular,
        ),
        textAlign: TextAlign.center,
        activeColor: AppColors.purple,
        inactiveColor: AppColors.grey,
      ),
      BottomNavyBarItem(
        icon: const Icon(Icons.wysiwyg_outlined),
        title: Text(
          Strings.historico,
          style: AppFontStyle.body14Regular,
        ),
        textAlign: TextAlign.center,
        activeColor: AppColors.purple,
        inactiveColor: AppColors.grey,
      ),
    ];
    quizzesController.onStatus = (value) => controller.setStatus = value;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _bootstrapHome(context);
    });
    _statusWorker = ever<RxStatus>(
      controller.statusObs,
      (status) {
        if (status.isError) popUpErro();
      },
    );
    super.initState();
  }

  Future<void> _bootstrapHome(BuildContext context) async {
    await Get.find<StudyReminderService>().reagendarSeAtivo();

    final atualizado =
        await Get.find<QuizContentVersionService>().detectarAtualizacaoConteudo();
    if (atualizado) showQuizContentUpdatedSnackbar();

    if (!context.mounted) return;
    await OnboardingMateriaSheet.showIfNeeded(context);
    if (!context.mounted) return;
    await StudyReminderPromptSheet.showIfNeeded(context);
  }

  @override
  void dispose() {
    _statusWorker?.dispose();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final proGate = Get.find<ProGate>();
    final plusCta = proGate.exibirPromoPlus
        ? const HabilitacaoQuizPlusCtaBanner()
        : const SizedBox.shrink();

    return Scaffold(
      appBar: const AppBarWidget(),
      body: Obx(
        () => LoadingBlurScreen(
          enabled: controller.isLoading,
          child: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: pageController,
            children: [
              QuizzesWidget(
                controller: quizzesController,
                topPromo: plusCta,
              ),
              const LearningHubWidget(),
              HistoricoWidget(
                historico: Get.find(),
                onIniciarQuiz: () {
                  controller.setPage = 0;
                  pageController.animateToPage(
                    0,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavBar(
          selectedIndex: controller.getPage,
          items: _bottomNavItems,
          onItemSelected: (value) {
            controller.setPage = value;
            pageController.animateToPage(
              value,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
        ),
      ),
    );
  }
}
