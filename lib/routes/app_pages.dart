import 'package:evds_staff/screens/detail_profile/detail_profile.dart';
import 'package:evds_staff/screens/detail_profile/detail_profile_binding.dart';
import 'package:evds_staff/screens/home/home.dart';
import 'package:evds_staff/screens/login/login.dart';
import 'package:evds_staff/screens/login/login_binding.dart';
import 'package:evds_staff/screens/main/main_screen.dart';
import 'package:evds_staff/screens/main/main_binding.dart';
import 'package:evds_staff/screens/reset_password/reset_password.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  static const initialRoute = AppRoutes.login;

  static final routes = [
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
      transition: Transition.rightToLeft,
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: AppRoutes.detailProfile,
      page: () => const DetailProfileScreen(),
      binding: DetailProfileBinding(),
    ),
    GetPage(
      name: AppRoutes.resetPassword,
      page: () => const ResetPasswordScreen(),
      binding: DetailProfileBinding(),
    ),
    GetPage(
      name: AppRoutes.main,
      page: () => const MainScreen(),
      binding: MainBinding(),
    )
  ];
}
