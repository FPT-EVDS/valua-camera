import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:valua_camera/providers/incident_provider.dart';
import 'package:valua_camera/repository/incident_repository.dart';

class IncidentController extends GetxController {
  final formKey = GlobalKey<FormState>();
  late TextEditingController descriptionController, noteController;
  final isLoading = false.obs;
  final IncidentRepository _provider = Get.find<IncidentProvider>();

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

  Future<void> submit() async {
    if (formKey.currentState!.validate()) {
      String description = descriptionController.text;
      String note = noteController.text;
      try {
        isLoading.value = true;
        final data = await _provider.submit(description, note);
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
