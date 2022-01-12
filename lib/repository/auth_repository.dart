<<<<<<< HEAD
import 'package:valua_staff/models/account.dart';
import 'package:valua_staff/models/app_user.dart';
=======
import 'package:evds_examinee/models/account.dart';
import 'package:evds_examinee/models/app_user.dart';
>>>>>>> 71e6696b1c463261fc7c9c044ce0de68c636f558

abstract class AuthRepository {
  Future<String> refreshToken();
  Future<AppUser> login(String email, String password);
  Future<Account> getProfile();
  Future<Account> updateProfile(Account newProfile);
  Future<String> changePassword(String currentPassword, String newPassword);
}
