import 'package:get/get.dart';
import 'package:valua_camera/providers/auth_provider.dart';
import 'package:valua_camera/providers/qr_provider.dart';
import 'package:valua_camera/screens/login/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
    Get.lazyPut<AuthProvider>(() => AuthProvider());
    Get.lazyPut<QRProvider>(() => QRProvider());
  }
}
