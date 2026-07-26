import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habilitacao_quiz/app/features/home/presentation/home_screen.dart';
import 'package:habilitacao_quiz/app/features/legal/presentation/legal_notice_screen.dart';
import 'package:habilitacao_quiz/app/features/questionario/presentation/questionario_screen.dart';
import 'package:habilitacao_quiz/app/features/resultado/presentation/resultado_screen.dart';
import 'package:habilitacao_quiz/app/features/routes/routes.dart';
import 'package:habilitacao_quiz/app/features/learning/presentation/learning_fichas_screen.dart';
import 'package:habilitacao_quiz/app/features/learning/presentation/learning_mapa_screen.dart';
import 'package:habilitacao_quiz/app/features/learning/presentation/learning_revisao_screen.dart';
import 'package:habilitacao_quiz/app/features/learning/presentation/learning_theme_screen.dart';
import 'package:habilitacao_quiz/app/features/learning/presentation/learning_trilha_screen.dart';
import 'package:habilitacao_quiz/app/features/historico/presentation/detalhe_simulado_screen.dart';
import 'package:habilitacao_quiz/app/features/promo/presentation/habilitacao_quiz_plus_screen.dart';
import 'package:habilitacao_quiz/app/features/resultado/domain/resultado_entity.dart';
import 'package:habilitacao_quiz/app/features/splash/splash_screen.dart';
import 'package:habilitacao_quiz/core/edition/app_edition.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: kAppDisplayName,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          scrolledUnderElevation: 0,
        ),
      ),
      initialRoute: Routes.init,
      getPages: [
        GetPage(
          name: Routes.init,
          page: () => const SplashScreen(),
        ),
        GetPage(
          name: Routes.resultado,
          page: () => ResultadoScreen(
            args: Get.arguments,
          ),
          transition: Transition.fade,
        ),
        GetPage(
          name: Routes.questionario,
          page: () => QuestionarioScreen(
            controller: Get.find(),
            quizEntity: Get.arguments,
          ),
        ),
        GetPage(
          name: Routes.home,
          page: () => HomeScreen(
            controller: Get.find(),
            quizzesController: Get.find(),
          ),
          transition: Transition.fadeIn,
          transitionDuration: const Duration(seconds: 2),
          showCupertinoParallax: false,
        ),
        GetPage(
          name: Routes.legalNotice,
          page: () => const LegalNoticeScreen(),
        ),
        GetPage(
          name: Routes.habilitacaoQuizPlus,
          page: () => const HabilitacaoQuizPlusScreen(),
        ),
        GetPage(
          name: Routes.detalheSimulado,
          page: () => DetalheSimuladoScreen(
            resultado: Get.arguments as ResultadoEntity,
          ),
        ),
        GetPage(
          name: Routes.aprenderTema,
          page: () => LearningThemeScreen(themeId: Get.arguments as String),
        ),
        GetPage(
          name: Routes.aprenderTrilha,
          page: () => const LearningTrilhaScreen(),
        ),
        GetPage(
          name: Routes.aprenderFichas,
          page: () => const LearningFichasScreen(),
        ),
        GetPage(
          name: Routes.aprenderFicha,
          page: () => LearningFichaScreen(fichaId: Get.arguments as String),
        ),
        GetPage(
          name: Routes.aprenderMapa,
          page: () => const LearningMapaScreen(),
        ),
        GetPage(
          name: Routes.aprenderRevisao,
          page: () => const LearningRevisaoScreen(),
        ),
      ],
    );
  }
}
