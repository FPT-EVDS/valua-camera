import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:valua_camera/constants/app.dart';
import 'package:valua_camera/models/exam_room.dart';
import 'package:valua_camera/providers/exam_room_provider.dart';
import 'package:valua_camera/repository/exam_room_repository.dart';

class MainController extends GetxController {
  final assignedExamRoom = Future<ExamRoom?>.value().obs;
  final examRoomName = ''.obs;
  final shouldShowCheckin = false.obs;
  final ExamRoomRepository _examRoomRepository = Get.find<ExamRoomProvider>();

  Future<void> getAssignedExamRoom({DateTime? date}) async {
    try {
      final data = _examRoomRepository.loadExamRoom().then((value) {
        final shiftBeginTime = DateTime.parse(value.shift.beginTime);
        final currentDate = DateTime.now();
        examRoomName.value = value.examRoomName;
        shouldShowCheckin.value = currentDate.isBefore(shiftBeginTime) &&
            currentDate.difference(shiftBeginTime) <
                const Duration(minutes: AppConstant.minutesBeforeCheckin);
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
