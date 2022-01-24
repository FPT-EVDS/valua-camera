import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:valua_staff/configs/http_service.dart';
import 'package:valua_staff/models/auth_user.dart';
import 'package:valua_staff/models/errors/AuthUserException.dart';
import 'package:valua_staff/repository/auth_repository.dart';

class AuthService implements AuthRepository {
  Dio dio = HttpService().dio;
  FlutterSecureStorage _storage = FlutterSecureStorage();

  @override
  Future<AuthUser> login(String email, String password) async {
    print(email + " " + password);
    final response = await dio.post('/authentication/login', data: {
      'email': email,
      'password': password,
    });
    final AuthUser user = AuthUser.fromJson(response.data["appUser"]);
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.setString("appUserId", user.appUserId.toString());
    await _storage.write(key: "userToken", value: response.data["jwtToken"]);
    return user;
  }

  @override
  Future<String?> refreshToken() async {
    final response = await dio.get('/authentication/refreshToken');
    await _storage.write(key: "userToken", value: response.data["jwt"]);
    return response.data["jwt"];
  }
}
