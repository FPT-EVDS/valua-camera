import 'package:get/get.dart';
import 'package:valua_camera/models/assigned_exam_room.dart';
import 'package:valua_camera/providers/exam_room_provider.dart';
import 'package:valua_camera/repository/exam_room_repository.dart';

class ExamRoomController extends GetxController {
  final assignedExamRoom = Future<AssignedExamRoom?>.value().obs;
  final examRoomName = ''.obs;
  final subjectsMessage = ''.obs;
  final totalExaminees = 0.obs;
  final toolsMessage = ''.obs;
  final ExamRoomRepository _examRoomRepository = Get.find<ExamRoomProvider>();

  Future<void> getAssignedExamRoom({DateTime? date}) async {
    int tempTotalExaminees = 0;
    String tempToolsMessage = '';
    String tempSubjectsMessage = '';
    try {
      final data = _examRoomRepository.loadExamRoom().then((value) {
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

  @override
  void onInit() {
    getAssignedExamRoom();
    super.onInit();
  }
}
