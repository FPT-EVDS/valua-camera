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
  late TextEditingController descriptionController, noteController;
  final isLoading = false.obs;
  final ReportRepository _provider = Get.find<ReportProvider>();

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
    descriptionController = TextEditingController();
    noteController = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
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

  Future<void> submitReport() async {
    if (formKey.currentState!.validate() && image.value != null) {
      String description = descriptionController.text;
      String note = noteController.text;
      // FIXME: Fix to exam room for the selected exam room
      final jsonData = jsonEncode({
        'examRoom': {
          'examRoomId': examRoom.examRooms[0].examRoomId,
        },
        "reportedUser": {
          "appUserId": selectedAttendance.value?.examinee.appUserId,
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
      try {
        isLoading.value = true;
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
