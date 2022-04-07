import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:valua_camera/models/attendance.dart';
import 'package:valua_camera/models/report.dart';
import 'package:valua_camera/providers/report_provider.dart';
import 'package:valua_camera/repository/report_repository.dart';
import 'package:valua_camera/screens/dashboard/dashboard_controller.dart';

class DetailViolationController extends GetxController {
  final String? reportId = Get.parameters["id"];
  final report = Rx<Report?>(null);
  final isResolved = false.obs;
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
  final DashboardController dashboardController =
      Get.find<DashboardController>();
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
    attendances = dashboardController.assignedExamRoom.value!.examRooms
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

  void handleChangeAttendance(Attendance? attendance) {
    selectedAttendance.value = attendance;
    if (attendance != null) {
      final violatorExamRoom = dashboardController
          .assignedExamRoom.value!.examRooms
          .firstWhere((element) => element.attendances.any(
              ((element) => element.attendanceId == attendance.attendanceId)));
      examRoomIdController.text = violatorExamRoom.examRoomId;
      examRoomNameController.text = violatorExamRoom.examRoomName;
    }
  }

  Future<void> submitReport() async {
    if (formKey.currentState!.validate()) {
      String examRoomId = examRoomIdController.text;
      String description = descriptionController.text;
      String note = noteController.text;
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
      try {
        isLoading.value = true;
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
        isResolved.value = report.solution != null;
        this.report.value = report;
        // Find attendance
        final attendance = attendances.firstWhere((element) =>
            element.subjectExaminee.examinee.appUserId ==
            report.reportedUser?.appUserId);
        selectedAttendance.value = attendance;
        descriptionController.text = report.description;
        noteController.text = report.note ?? '';
        examRoomIdController.text = report.examRoom.examRoomId;
        examRoomNameController.text = report.examRoom.examRoomName;
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
