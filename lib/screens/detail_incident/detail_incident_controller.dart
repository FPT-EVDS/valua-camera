import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:valua_camera/models/report.dart';
import 'package:valua_camera/providers/report_provider.dart';
import 'package:valua_camera/repository/report_repository.dart';

class DetailIncidentController extends GetxController {
  final String? reportId = Get.parameters["id"];
  final isResolved = false.obs;
  final report = Rx<Report?>(null);
  final image = Rx<XFile?>(null);
  final ImagePicker _picker = ImagePicker();
  final formKey = GlobalKey<FormState>();
  late TextEditingController examRoomIdController,
      examRoomNameController,
      descriptionController,
      noteController;
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
    examRoomIdController = TextEditingController();
    examRoomNameController = TextEditingController();
    descriptionController = TextEditingController();
    noteController = TextEditingController();
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
  }

  Future<void> submitReport() async {
    if (formKey.currentState!.validate()) {
      String description = descriptionController.text;
      String note = noteController.text;
      isLoading.value = true;
      final jsonData = jsonEncode({
        'examRoom': {
          'examRoomId': report.value?.examRoom.examRoomId,
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
      try {
        await _provider.updateReport(reportId!, _formData);
        await Fluttertoast.showToast(
          msg: "Update report success",
          backgroundColor: Colors.grey.shade700,
        );
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

  Future<Report?> fetchReport() async {
    if (reportId != null) {
      isLoading.value = true;
      try {
        final report = await _provider.getReport(reportId!);
        this.report.value = report;
        isResolved.value = report.solution != null;
        examRoomIdController.text = report.examRoom.examRoomId;
        examRoomNameController.text = report.examRoom.examRoomName;
        descriptionController.text = report.description;
        noteController.text = report.note ?? '';
        return report;
      } catch (e) {
        Fluttertoast.showToast(
          msg: e.toString(),
          backgroundColor: Colors.grey.shade700,
        );
      } finally {
        isLoading.value = false;
      }
    } else {
      throw Error();
    }
  }
}
