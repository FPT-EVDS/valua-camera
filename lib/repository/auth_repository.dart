import 'package:valua_camera/models/account.dart';
import 'package:valua_camera/models/app_user.dart';

abstract class AuthRepository {
  Future<String> refreshToken();
  Future<AppUser> login(String email, String password);
  Future<Account> getProfile();
  Future<Account> updateProfile(Account newProfile);
  Future<String> changePassword(String currentPassword, String newPassword);
  Future<AppUser> loginWithGoogle(String idToken);
}
