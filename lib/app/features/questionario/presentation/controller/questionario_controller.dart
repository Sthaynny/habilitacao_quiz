import 'package:get/get.dart';
import 'package:quiz_car/app/features/shared/domain/entities/quiz_entity.dart';

class QuestionarioController extends GetxController {
  void init({required QuizEntity quizEntity}) {
    this.quizEntity = quizEntity;
  }

  late final QuizEntity quizEntity;
}
