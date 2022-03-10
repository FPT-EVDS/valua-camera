import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:valua_camera/constants/app.dart';
import 'package:valua_camera/providers/auth_provider.dart';

class BaseProvider extends GetConnect {
  // final _baseUrl = 'http://10.0.2.2:8080';
  final _baseUrlOnRealDevice = "http://192.168.1.12:8080";
  final _storage = GetStorage(AppConstant.storageKey);

  @override
  void onInit() {
    httpClient.baseUrl = _baseUrlOnRealDevice;
    httpClient.defaultContentType = "application/json";
    //Autenticator will be called 1 times if HttpStatus is
    //HttpStatus.unauthorized
    httpClient.maxAuthRetries = 1;
    httpClient.timeout = const Duration(seconds: 15);

    httpClient.addRequestModifier<dynamic>((request) async {
      String? token = _storage.read(AppConstant.accessToken);
      if (token != null && !request.url.path.endsWith("login")) {
        request.headers['Authorization'] = 'Bearer $token';
      }
      return request;
    });

    // call refresh token when 401
    httpClient.addAuthenticator<dynamic>((request) async {
      try {
        final token = await Get.find<AuthProvider>().refreshToken();
        _storage.write(AppConstant.accessToken, token);
        // Set the header
        request.headers['Authorization'] = 'Bearer $token';
      } catch (error) {
        _storage.remove(AppConstant.accessToken);
        _storage.remove(AppConstant.refreshToken);
      }
      return request;
    });

    super.onInit();
  }
}
