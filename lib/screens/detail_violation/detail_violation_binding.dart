import 'package:evds_staff/screens/detail_violation/detail_violation_controller.dart';
import 'package:get/get.dart';

class DetailViolationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailViolationController>(() => DetailViolationController());
  }
}
