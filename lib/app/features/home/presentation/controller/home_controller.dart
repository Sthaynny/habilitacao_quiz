import 'package:get/get.dart';

class HomeController extends GetxController {
  final _status = RxStatus.empty().obs;
  final _page = 0.obs;

  set setStatus(RxStatus value) => _status.value = value;

  set setPage(int value) => _page.value = value;
  int get getPage => _page.value;
}

extension HomeContrrollerGets on HomeController {
  bool get isSuccess => _status.value.isSuccess;
  bool get isLoading => _status.value.isLoading;
  bool get isError => _status.value.isError;
}
