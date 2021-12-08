import 'package:get/get.dart';

class DetailViolationController extends GetxController {
  final isUpdating = false.obs;

  toggleUpdate() {
    isUpdating.value = !isUpdating.value;
  }
}
