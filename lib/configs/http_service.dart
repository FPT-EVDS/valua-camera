import 'package:dio/dio.dart';
import 'package:valua_staff/services/auth_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart'
    hide Options;

class HttpService {
  late Dio dio;
  late FlutterSecureStorage _storage;
  String? _token;
  // if you run emulator
  final baseUrl = "http://10.0.2.2:8080";
  // if you run on real device, run ipconfig and paste your ip here
  final baseUrlOnRealDevice = "http://192.168.0.193:8080";

  HttpService() {
    _storage = new FlutterSecureStorage();
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
      ),
    );
    _initInterceptor(dio);
  }

  _retry(RequestOptions requestOptions, Dio dio) async {
    Options options = new Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return dio.request<dynamic>(requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options);
  }

  _initInterceptor(Dio dio) async {
    _storage = new FlutterSecureStorage();
    dio.interceptors.clear();
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          _token = await _storage.read(key: "userToken");
          if (_token != null)
            options.headers["Authorization"] = "Bearer $_token";
          if (options.path == "/authentication/refreshToken") {
            options.headers["isRefreshToken"] = true;
          }
          return handler.next(options);
        },
        onError: (DioError error, handler) async {
          if (error.response?.statusCode == 403 ||
              error.response?.statusCode == 401) {
            AuthService authService = new AuthService();
            RequestOptions options = error.response!.requestOptions;
            dio.interceptors.requestLock.lock();
            await authService.refreshToken();
            dio.interceptors.requestLock.unlock();
            return _retry(options, dio);
          }
          return handler.next(error);
        },
      ),
    );
  }
}
