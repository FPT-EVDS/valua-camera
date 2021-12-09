import 'package:evds_staff/models/account.dart';
import 'package:evds_staff/models/app_user.dart';

abstract class AuthRepository {
  Future<String> refreshToken();
  Future<AppUser> login(String email, String password);
  Future<Account> getProfile();
}
