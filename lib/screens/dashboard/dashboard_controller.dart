import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:valua_camera/constants/app.dart';
import 'package:valua_camera/models/assigned_exam_room.dart';
import 'package:valua_camera/providers/exam_room_provider.dart';
import 'package:valua_camera/repository/exam_room_repository.dart';
import 'package:valua_camera/routes/app_pages.dart';

class DashboardController extends GetxController {
  final assignedExamRoom = Rx<AssignedExamRoom?>(null);
  final ExamRoomRepository _examRoomRepository = Get.find<ExamRoomProvider>();

  Future<AssignedExamRoom> getAssignedExamRoom({DateTime? date}) async {
    try {
      final data = _examRoomRepository.loadExamRoom().then((value) {
        assignedExamRoom.value = value;
        return value;
      });
      return data;
    } catch (err) {
      throw Exception(err);
    }
  }

  void logout() {
    final _storage = GetStorage(AppConstant.storageKey);
    _storage.erase();
  }

  Future<void> finishExam() async {
    try {
      final data = await _examRoomRepository.finishExam();
      if (data) {
        logout();
        Fluttertoast.showToast(
          msg: "Finish exam successfully",
          backgroundColor: Colors.grey.shade700,
        );
        Get.offAllNamed(AppRoutes.login);
      }
    } catch (err) {
      Get.back();
      Fluttertoast.showToast(
        msg: err.toString(),
        backgroundColor: Colors.grey.shade700,
      );
    }
  }

  @override
  void onInit() {
    getAssignedExamRoom();
    super.onInit();
  }
}
