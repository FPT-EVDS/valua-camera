import 'package:evds_examinee/screens/detail_profile/detail_profile_controller.dart';
import 'package:get/get.dart';

class DetailProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailProfileController>(() => DetailProfileController());
  }
}
