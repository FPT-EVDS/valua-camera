// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:valua_camera/models/exam_room.dart';
import 'package:valua_camera/providers/exam_room_provider.dart';
import 'package:valua_camera/providers/regulation_provider.dart';
import 'package:valua_camera/repository/exam_room_repository.dart';
import 'package:valua_camera/repository/regulation_repository.dart';

class RegulationController extends GetxController {
  final formKey = GlobalKey<FormState>();
  late TextEditingController descriptionController, noteController;
  final isLoading = false.obs;
  final RegulationRepository _provider = Get.find<RegulationProvider>();
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

  Future<void> submitReport(
      String? imageUrl, String violatorId, String examRoomId) async {
    if (formKey.currentState!.validate()) {
      String description = descriptionController.text;
      String note = noteController.text;
      try {
        isLoading.value = true;
        final data = await _provider.submitReport(
            description, note, imageUrl, violatorId, examRoomId);
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
