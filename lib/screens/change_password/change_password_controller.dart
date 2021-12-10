import 'package:cool_alert/cool_alert.dart';
import 'package:evds_examinee/providers/auth_provider.dart';
import 'package:evds_examinee/repository/auth_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final genders = ["Male", "Female"].obs;
  late TextEditingController currentPasswordController,
      newPasswordController,
      confirmPasswordController;
  final AuthRepository _provider = Get.find<AuthProvider>();
  final isLoading = false.obs;

  @override
  void onInit() {
    currentPasswordController = TextEditingController();
    newPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> updatePassword(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      try {
        isLoading.value = true;
        await _provider.changePassword(
            currentPasswordController.text, newPasswordController.text);
        formKey.currentState?.reset();
        CoolAlert.show(
          context: context,
          type: CoolAlertType.success,
          text: "Update password success",
        );
      } catch (e) {
        CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          text: e.toString(),
        );
      } finally {
        isLoading.value = false;
      }
    }
  }
}
