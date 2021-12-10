import 'package:evds_examinee/providers/auth_provider.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class BaseProvider extends GetConnect {
  final _baseUrl = 'http://10.0.2.2:8080';
  // final _baseUrlOnRealDevice = "http://192.168.1.91:8080";
  final _storage = GetStorage('evds_examinee');

  @override
  void onInit() {
    httpClient.baseUrl = _baseUrl;
    httpClient.defaultContentType = "application/json";
    //Autenticator will be called 1 times if HttpStatus is
    //HttpStatus.unauthorized
    httpClient.maxAuthRetries = 1;
    httpClient.timeout = const Duration(seconds: 15);

    httpClient.addRequestModifier<dynamic>((request) async {
      String? token = _storage.read("access_token");
      if (token != null && !request.url.path.endsWith("login")) {
        request.headers['Authorization'] = 'Bearer $token';
      }
      return request;
    });

    // call refresh token when 401
    httpClient.addAuthenticator<dynamic>((request) async {
      try {
        final token = await Get.find<AuthProvider>().refreshToken();
        _storage.write("access_token", token);
        // Set the header
        request.headers['Authorization'] = 'Bearer $token';
      } catch (error) {
        _storage.remove("access_token");
        _storage.remove("refresh_token");
      }
      return request;
    });

    super.onInit();
  }
}
