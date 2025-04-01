import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:habilitacao_quiz/app/features/historico/presentation/historico_widget.dart';
import 'package:habilitacao_quiz/app/features/home/presentation/components/app_bar.dart';
import 'package:habilitacao_quiz/app/features/home/presentation/components/bottom_nav_bar.dart';
import 'package:habilitacao_quiz/app/features/home/presentation/components/quizzes/controller/quizzes_controller.dart';
import 'package:habilitacao_quiz/app/features/home/presentation/components/quizzes/quizzes_widget.dart';
import 'package:habilitacao_quiz/app/features/home/presentation/controller/home_controller.dart';
import 'package:habilitacao_quiz/app/shared/presentation/pages/loading_blur_screen.dart';
import 'package:habilitacao_quiz/core/mixins/pop_up_mixin.dart';
import 'package:habilitacao_quiz/core/styles/app_styles.dart';
import 'package:habilitacao_quiz/core/utils/ad_helper.dart';
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
  final ValueNotifier<BannerAd?> bannerAdNotifier = ValueNotifier(null);

  @override
  void initState() {
    quizzesController = widget.quizzesController;
    quizzesController.onStatus = (value) => controller.setStatus = value;
    BannerAd(
      adUnitId: AdHelper.bottomAd,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          bannerAdNotifier.value = ad as BannerAd;
        },
        onAdFailedToLoad: (ad, err) {
          debugPrint('Failed to load a banner ad: ${err.message}');
          ad.dispose();
        },
      ),
    ).load();
    super.initState();
  }

  @override
  void dispose() {
    bannerAdNotifier.value?.dispose();
    bannerAdNotifier.dispose();
    pageController.dispose();
    quizzesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isError) {
        popUpErro();
      }
      return LoadingBlurScreen(
        enabled: controller.isLoading,
        child: Scaffold(
          appBar: const AppBarWidget(),
          body: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: pageController,
            children: [
              QuizzesWidget(
                controller: quizzesController,
                bottomAd: bottomAd,
              ),
              HistoricoWidget(
                historico: Get.find(),
                bottomAd: bottomAd,
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
                ),
              ],
              onItemSelected: (value) {
                controller.setPage = value;
                pageController.animateToPage(
                  value,
                  duration: const Duration(milliseconds: 700),
                  curve: Curves.easeIn,
                );
              },
            ),
          ),
        ),
      );
    });
  }

  Widget get bottomAd => ValueListenableBuilder(
        valueListenable: bannerAdNotifier,
        builder: (context, bannerAd, child) {
          if (bannerAd != null) {
            return SizedBox(
              width: bannerAd.size.width.toDouble(),
              height: bannerAd.size.height.toDouble(),
              child: AdWidget(ad: bannerAd),
            );
          }
          return Container();
        },
      );
}
