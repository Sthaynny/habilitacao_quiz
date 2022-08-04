import 'package:get/get.dart';
import 'package:habilitacao_quiz/app/shared/data/datasources/quiz_datasource.dart';
import 'package:habilitacao_quiz/app/shared/data/repositories/quiz_repository.dart';
import 'package:habilitacao_quiz/app/shared/domain/repositories/iquiz_repository.dart';
import 'package:habilitacao_quiz/core/i_injection_conetiner.dart';

class SharedInjectionContainer implements IInjectionContainer {
  @override
  void call() {
    Get.lazyPut<QuizDatasource>(() => QuizDatasource());
    Get.lazyPut<IQuizRepository>(() => QuizRepository(Get.find()));
    Get.lazyPut<QuizDatasource>(() => QuizDatasource());
    Get.lazyPut<IQuizRepository>(() => QuizRepository(Get.find()));
    Get.lazyPut<IQuizRepository>(() => QuizRepository(Get.find()));
  }
}
