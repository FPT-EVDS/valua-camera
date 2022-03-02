// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:valua_camera/models/exam_room.dart';
import 'package:valua_camera/providers/exam_room_provider.dart';
import 'package:valua_camera/providers/incident_provider.dart';
import 'package:valua_camera/repository/exam_room_repository.dart';
import 'package:valua_camera/repository/incident_repository.dart';

class IncidentController extends GetxController {
  final formKey = GlobalKey<FormState>();
  late TextEditingController descriptionController, noteController;
  final isLoading = false.obs;
  final assignedExamRoom = Future<ExamRoom?>.value().obs;

  final IncidentRepository _provider = Get.find<IncidentProvider>();
  final ExamRoomRepository _examRoomRepository = Get.find<ExamRoomProvider>();

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

  Future<void> submitReport(String? imageUrl, String examRoomId) async {
    if (formKey.currentState!.validate()) {
      String description = descriptionController.text;
      String note = noteController.text;
      try {
        isLoading.value = true;
        print(description);
        print(note);
        print(imageUrl);
        print(examRoomId);
        final data = await _provider.submitReport(
          description,
          note,
          examRoomId,
          imageUrl,
        );
        print(data.reportId);
      } catch (e) {
        Fluttertoast.showToast(
          msg: e.toString(),
          backgroundColor: Colors.grey.shade700,
        );
      } finally {
        isLoading.value = false;
      }
    }
  }
}
