import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:valua_camera/constants/app.dart';
import 'package:valua_camera/models/account.dart';
import 'package:valua_camera/models/app_user.dart';
import 'package:valua_camera/providers/base_provider.dart';
import 'package:valua_camera/repository/auth_repository.dart';

class AuthProvider extends BaseProvider implements AuthRepository {
  final GetStorage _storage = GetStorage(AppConstant.storageKey);

  @override
  Future<AppUser> login(String email, String password) async {
    final response = await post("/authentication/login", {
      'email': email,
      'password': password,
    });
    if (response.status.hasError) {
      throw (response.body);
    }
    return AppUser.fromJson(response.body);
  }

  @override
  Future<String> refreshToken() async {
    final response = await get(
      "/authentication/refreshToken",
      headers: {
        "refreshToken": _storage.read(AppConstant.refreshToken).toString(),
      },
    );
    if (response.status.hasError) {
      throw (response.body);
    }
    return response.body["token"];
  }

  @override
  Future<Account> getProfile() async {
    final response = await get("/authentication/profile");
    if (response.status.hasError) {
      throw (response.body);
    }
    return Account.fromJson(response.body);
  }

  @override
  Future<Account> updateProfile(Account newProfile) async {
    final response = await put(
      "/authentication/profile",
      jsonEncode(newProfile),
    );
    if (response.status.hasError) {
      throw (response.body);
    }
    return Account.fromJson(response.body);
  }

  @override
  Future<String> changePassword(
      String currentPassword, String newPassword) async {
    final response = await post("/authentication/changePassword", {
      'currentPassword': currentPassword,
      'newPassword': newPassword,
    });
    if (response.status.hasError) {
      throw (response.body);
    }
    return response.body;
  }

  @override
  Future<AppUser> loginWithGoogle(String idToken) async {
    final response = await post("/authentication/verify/firebase", idToken);
    if (response.status.hasError) {
      throw (response.body);
    }
    return AppUser.fromJson(response.body);
  }
}
