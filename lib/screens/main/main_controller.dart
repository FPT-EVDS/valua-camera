import 'package:get/get.dart';

class MainController extends GetxController {
  final tabIndex = 0.obs;
  final appBarTitle = "".obs;
  final List<String> _listTitles = ["", "Notifications", ""];

  void changeTabIndex(int newTabIndex) {
    tabIndex.value = newTabIndex;
    appBarTitle.value = _listTitles[newTabIndex];
  }
}
