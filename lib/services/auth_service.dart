import 'package:valua_camera/constants/app.dart';
import 'package:valua_camera/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthService extends GetxService {
  final _storage = GetStorage(AppConstant.storageKey);
  String? token;

  @override
  void onInit() {
    token = _storage.read(AppConstant.accessToken);
    _storage.listenKey(AppConstant.accessToken, (value) {
      if (value == null) {
        Get.offAllNamed(AppRoutes.login);
      }
      token = value.toString();
    });
    super.onInit();
  }

  bool hasLogin() => token != null;
}
