// ignore_for_file: unused_local_variable, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valua_camera/models/report.dart';
import 'package:valua_camera/providers/report_provider.dart';
import 'package:valua_camera/repository/report_repository.dart';

class ReportController extends GetxController {
  final formKey = GlobalKey<FormState>();

  late TextEditingController descriptionController, noteController;
  final ReportRepository _reportRepository = Get.find<ReportProvider>();

  @override
  void onInit() {
    descriptionController = TextEditingController();
    noteController = TextEditingController();
    getListReports();
    super.onInit();
  }

  @override
  void dispose() {
    descriptionController.dispose();
    noteController.dispose();
    super.dispose();
  }

  Future<List<Report>> getListReports() async {
    try {
      final data = await _reportRepository.getReport();
      print(data.totalItems);
      return data.reports;
    } catch (err) {
      throw Exception(err);
    }
  }
}
