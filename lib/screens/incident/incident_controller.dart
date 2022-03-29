import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:valua_camera/models/assigned_exam_room.dart';
import 'package:valua_camera/providers/report_provider.dart';
import 'package:valua_camera/repository/report_repository.dart';

class IncidentController extends GetxController {
  final AssignedExamRoom examRoom = Get.arguments;
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
  }

  Future<void> submitReport() async {
    if (formKey.currentState!.validate()) {
      String description = descriptionController.text;
      String note = noteController.text;
      isLoading.value = true;
      try {
        await Future.wait(examRoom.examRooms.map((e) {
          final jsonData = jsonEncode({
            'examRoom': {
              'examRoomId': e.examRoomId,
            },
            'description': description,
            'note': note,
            'reportType': 1,
          });
          final FormData _formData = FormData({
            'report': jsonData,
            if (image.value != null)
              'image': MultipartFile(
                File(image.value!.path),
                filename: image.value!.name,
              ),
          });
          return _provider.createReport(_formData);
        }));
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
    }
  }
}
