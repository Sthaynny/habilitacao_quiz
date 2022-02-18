import 'package:get/get.dart';
import 'package:quiz_car/app/shared/data/datasources/quiz_datasource.dart';
import 'package:quiz_car/app/shared/data/repositories/quiz_repository.dart';
import 'package:quiz_car/app/shared/domain/repositories/iquiz_repository.dart';
import 'package:quiz_car/core/i_injection_conetiner.dart';

class SharedInjectionContainer implements IInjectionContainer {
  @override
  void call() {
    Get.lazyPut<QuizDatasource>(() => QuizDatasource());
    Get.lazyPut<IQuizRepository>(() => QuizRepository(Get.find()));
  }
}
