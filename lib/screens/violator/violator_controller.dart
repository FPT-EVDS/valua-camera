import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valua_camera/models/attendance.dart';
import 'package:valua_camera/models/exam_room.dart';
import 'package:valua_camera/providers/exam_room_provider.dart';
import 'package:valua_camera/repository/exam_room_repository.dart';

class ViolatorController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final id = "".obs;
  final imageUrl = "".obs;
  final fullName = "".obs;
  final pos = 0.obs;

  late TextEditingController descriptionController, noteController;
  final ExamRoomRepository _examRoomRepository = Get.find<ExamRoomProvider>();

  final assignedExamRoom = Future<ExamRoom?>.value().obs;

  @override
  void onInit() {
    descriptionController = TextEditingController();
    noteController = TextEditingController();
    getAssignedExamRoom();
    super.onInit();
  }

  @override
  void dispose() {
    descriptionController.dispose();
    noteController.dispose();
    super.dispose();
  }

  Future<void> getAssignedExamRoom() async {
    try {
      final data = _examRoomRepository.getCurrentExamRoom();
      assignedExamRoom.value = data;
    } catch (err) {
      throw Exception(err);
    }
  }

  void handleChangeViolator(Attendance? attendance) {
    if (attendance != null) {
      id.value = attendance.examinee!.companyId;
      imageUrl.value = attendance.examinee!.imageUrl!;
      fullName.value = attendance.examinee!.fullName;
      pos.value = attendance.position;
    }
  }
}
