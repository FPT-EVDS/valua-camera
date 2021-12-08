import 'package:evds_staff/screens/detail_evidence/detail_evidence_controller.dart';
import 'package:get/get.dart';

class DetailEvidenceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailEvidenceController>(() => DetailEvidenceController());
  }
}
