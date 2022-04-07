import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:valua_camera/models/assigned_exam_room.dart';
import 'package:valua_camera/models/attendance.dart';
import 'package:valua_camera/providers/report_provider.dart';
import 'package:valua_camera/repository/report_repository.dart';

class ViolationController extends GetxController {
  final AssignedExamRoom examRoom = Get.arguments;
  final imageError = ''.obs;
  final selectedAttendance = Rx<Attendance?>(null);
  final image = Rx<XFile?>(null);
  final ImagePicker _picker = ImagePicker();
  final formKey = GlobalKey<FormState>();
  late TextEditingController examRoomIdController,
      examRoomNameController,
      descriptionController,
      noteController;
  final isLoading = false.obs;
  final ReportRepository _provider = Get.find<ReportProvider>();
  late final List<Attendance> attendances;

  void pickImage(int index) async {
    ImageSource source = index == 0 ? ImageSource.gallery : ImageSource.camera;
    final image = await _picker.pickImage(source: source);
    if (image != null) {
      this.image.value = image;
      imageError.value = '';
    }
  }

  @override
  void onInit() {
    examRoomIdController = TextEditingController();
    examRoomNameController = TextEditingController();
    descriptionController = TextEditingController();
    noteController = TextEditingController();
    attendances = examRoom.examRooms
        .map((e) => e.attendances)
        .expand((element) => element)
        .toList();
    super.onInit();
  }

  @override
  void dispose() {
    examRoomIdController.dispose();
    examRoomNameController.dispose();
    descriptionController.dispose();
    noteController.dispose();
    super.dispose();
  }

  void resetForm() {
    formKey.currentState?.reset();
    image.value = null;
    imageError.value = '';
    selectedAttendance.value = null;
  }

  void handleChangeAttendance(Attendance? attendance) {
    selectedAttendance.value = attendance;
    if (attendance != null) {
      final violatorExamRoom = examRoom.examRooms.firstWhere((element) =>
          element.attendances.any(
              ((element) => element.attendanceId == attendance.attendanceId)));
      examRoomIdController.text = violatorExamRoom.examRoomId;
      examRoomNameController.text = violatorExamRoom.examRoomName;
    }
  }

  Future<void> submitReport() async {
    if (formKey.currentState!.validate() && image.value != null) {
      String examRoomId = examRoomIdController.text;
      String description = descriptionController.text;
      String note = noteController.text;
      isLoading.value = true;
      try {
        final jsonData = jsonEncode({
          'examRoom': {
            'examRoomId': examRoomId,
          },
          "reportedUser": {
            "appUserId":
                selectedAttendance.value?.subjectExaminee.examinee.appUserId,
          },
          'description': description,
          'note': note,
          'reportType': 2,
        });
        final FormData _formData = FormData({
          'report': jsonData,
          if (image.value != null)
            'image': MultipartFile(
              File(image.value!.path),
              filename: image.value!.name,
            ),
        });
        await _provider.createReport(_formData);
        await Fluttertoast.showToast(
          msg: "Create report success",
          backgroundColor: Colors.grey.shade700,
        );
        resetForm();
      } catch (e) {
        Fluttertoast.showToast(
          msg: e.toString(),
          backgroundColor: Colors.grey.shade700,
        );
      } finally {
        isLoading.value = false;
      }
    } else {
      if (image.value == null) {
        imageError.value = 'Image is required';
      }
    }
  }
}
