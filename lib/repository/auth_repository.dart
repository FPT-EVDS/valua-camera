import 'package:valua_staff/models/auth_user.dart';

abstract class AuthRepository {
  Future<String?> refreshToken();
  Future<AuthUser> login(String email, String password);
}
