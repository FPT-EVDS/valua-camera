import 'package:evds_staff/providers/auth_provider.dart';
import 'package:evds_staff/repository/auth_repository.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final AuthRepository authRepository = Get.find<AuthProvider>();
}
