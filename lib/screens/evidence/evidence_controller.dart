import 'package:get/get.dart';

class EvidenceController extends GetxController {
  final currentSelection = 0.obs;
  final fakeStatus = 0.obs;

  void handleChangeSegment(int? index) {
    if (index != null) {
      currentSelection.value = index;
      fakeStatus.value = index;
    }
  }
}
