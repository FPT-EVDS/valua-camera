import 'package:valua_staff/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthService extends GetxService {
  final _storage = GetStorage('valua_staff');
  String? token;

  @override
  void onInit() {
    token = _storage.read('access_token');
    _storage.listenKey('access_token', (value) {
      if (value == null) {
        Get.offAllNamed(AppRoutes.login);
      }
      token = value.toString();
    });
    super.onInit();
  }

  bool hasLogin() => token != null;
}
