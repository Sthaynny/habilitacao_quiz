import 'package:get/get.dart';
import 'package:habilitacao_quiz/app/shared/utils/quiz_enum.dart';

class HomeController extends GetxController {
  final _status = RxStatus.empty().obs;
  final _page = 0.obs;
  final _materiaFoco = Rxn<QuizEnum>();

  Rx<RxStatus> get statusObs => _status;

  Rxn<QuizEnum> get materiaFocoObs => _materiaFoco;

  set setStatus(RxStatus value) => _status.value = value;

  set setPage(int value) => _page.value = value;
  int get getPage => _page.value;

  void definirMateriaFoco(QuizEnum? quiz) => _materiaFoco.value = quiz;
}

extension HomeContrrollerGets on HomeController {
  bool get isSuccess => _status.value.isSuccess;
  bool get isLoading => _status.value.isLoading;
  bool get isError => _status.value.isError;
}
