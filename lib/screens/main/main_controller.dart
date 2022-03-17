import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:valua_camera/constants/app.dart';
import 'package:valua_camera/enums/shift_status.dart';
import 'package:valua_camera/models/assigned_exam_room.dart';
import 'package:valua_camera/providers/exam_room_provider.dart';
import 'package:valua_camera/repository/exam_room_repository.dart';

class MainController extends GetxController {
  final assignedExamRoom = Future<AssignedExamRoom?>.value().obs;
  final message = ''.obs;
  final examRoomName = ''.obs;
  final shouldShowCheckin = false.obs;
  final ExamRoomRepository _examRoomRepository = Get.find<ExamRoomProvider>();

  Future<void> getAssignedExamRoom({DateTime? date}) async {
    try {
      final data = _examRoomRepository.loadExamRoom().then((value) {
        if (value.currentShift.status == ShiftStatus.ongoing) {
          shouldShowCheckin.value = true;
        }
        return value;
      });
      assignedExamRoom.value = data;
    } catch (err) {
      throw Exception(err);
    }
  }

  void logout() {
    final _storage = GetStorage(AppConstant.storageKey);
    _storage.erase();
  }

  @override
  void onInit() {
    getAssignedExamRoom();
    super.onInit();
  }
}
