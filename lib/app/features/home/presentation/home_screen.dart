import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habilitacao_quiz/app/features/historico/presentation/historico_widget.dart';
import 'package:habilitacao_quiz/app/features/home/presentation/components/app_bar.dart';
import 'package:habilitacao_quiz/app/features/home/presentation/components/bottom_nav_bar.dart';
import 'package:habilitacao_quiz/app/features/home/presentation/components/quizzes/controller/quizzes_controller.dart';
import 'package:habilitacao_quiz/app/features/home/presentation/components/quizzes/quizzes_widget.dart';
import 'package:habilitacao_quiz/app/features/home/presentation/controller/home_controller.dart';
import 'package:habilitacao_quiz/app/shared/presentation/pages/loading_blur_screen.dart';
import 'package:habilitacao_quiz/core/mixins/pop_up_mixin.dart';
import 'package:habilitacao_quiz/core/styles/app_styles.dart';
import 'package:habilitacao_quiz/core/utils/strings.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
    required this.controller,
    required this.quizzesController,
  }) : super(key: key);
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

  @override
  void initState() {
    quizzesController = widget.quizzesController;
    quizzesController.onStatus = (value) => controller.setStatus = value;
    _statusWorker = ever<RxStatus>(
      controller.statusObs,
      (status) {
        if (status.isError) popUpErro();
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    _statusWorker?.dispose();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => LoadingBlurScreen(
        enabled: controller.isLoading,
        child: Scaffold(
          appBar: const AppBarWidget(),
          body: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: pageController,
            children: [
              QuizzesWidget(
                controller: quizzesController,
              ),
              HistoricoWidget(
                historico: Get.find(),
              )
            ],
          ),
          bottomNavigationBar: Obx(
            () => BottomNavBar(
              selectedIndex: controller.getPage,
              items: [
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
                  icon: const Icon(
                    Icons.wysiwyg_outlined,
                  ),
                  title: Text(
                    Strings.historico,
                    style: AppFontStyle.body14Regular,
                  ),
                  textAlign: TextAlign.center,
                  activeColor: AppColors.purple,
                  inactiveColor: AppColors.grey,
                ),
              ],
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
        ),
      ),
    );
  }
}
