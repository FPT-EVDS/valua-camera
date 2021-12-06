import 'package:evds_staff/screens/shift/shift_controller.dart';
import 'package:get/get.dart';

class ShiftBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShiftController>(() => ShiftController());
  }
}
