import 'package:get/get.dart';
import 'package:habilitacao_quiz/core/utils/semantics_announce.dart';
import 'package:habilitacao_quiz/core/utils/strings.dart';

void showQuizContentUpdatedSnackbar() {
  announceForAccessibility(Strings.quizContentAtualizado);
  Get.snackbar(
    Strings.quizContentAtualizadoTitulo,
    Strings.quizContentAtualizado,
    snackPosition: SnackPosition.BOTTOM,
  );
}
