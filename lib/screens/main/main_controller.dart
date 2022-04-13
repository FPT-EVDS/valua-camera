import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:valua_camera/constants/app.dart';
import 'package:valua_camera/enums/shift_status.dart';
import 'package:valua_camera/models/assigned_exam_room.dart';
import 'package:valua_camera/providers/exam_room_provider.dart';
import 'package:valua_camera/repository/exam_room_repository.dart';
import 'package:valua_camera/routes/app_pages.dart';

class MainController extends GetxController {
  final assignedExamRoom = Future<AssignedExamRoom?>.value().obs;
  final examRoomName = ''.obs;
  final subjectsMessage = ''.obs;
  final totalExaminees = 0.obs;
  final toolsMessage = ''.obs;
  final shouldShowCheckin = false.obs;
  final ExamRoomRepository _examRoomRepository = Get.find<ExamRoomProvider>();

  Future<void> getAssignedExamRoom({DateTime? date}) async {
    int tempTotalExaminees = 0;
    String tempToolsMessage = '';
    String tempSubjectsMessage = '';
    try {
      final data = _examRoomRepository.loadExamRoom().then((value) {
        if (value.examRooms[0].startTime != null) {
          Get.offAllNamed(AppRoutes.dashboard);
        }
        if (value.currentShift.status == ShiftStatus.ongoing) {
          shouldShowCheckin.value = true;
        } else {
          shouldShowCheckin.value = false;
        }
        final tempExamRooms = value.examRooms;
        // Sort attendances by position when init
        for (int i = 0; i < tempExamRooms.length; i++) {
          final examRoom = tempExamRooms[i];
          examRoom.attendances.sort((a, b) => a.position.compareTo(b.position));
          tempTotalExaminees += examRoom.attendances.length;
          tempToolsMessage = examRoom.subjectSemester.subject.tools
              .map((e) => e.toolName)
              .join(", ");
          if (i != tempExamRooms.length - 1) {
            tempSubjectsMessage +=
                "${examRoom.subjectSemester.subject.subjectCode}, ";
          } else {
            tempSubjectsMessage += examRoom.subjectSemester.subject.subjectCode;
          }
        }
        totalExaminees.value = tempTotalExaminees;
        toolsMessage.value = tempToolsMessage;
        subjectsMessage.value = tempSubjectsMessage;
        examRoomName.value = "${value.currentRoom.roomName}'s exam information";
        value.examRooms = tempExamRooms;
        return value;
      });
      assignedExamRoom.value = data;
      return;
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
