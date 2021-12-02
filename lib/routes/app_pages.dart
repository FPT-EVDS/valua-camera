import 'package:evds_staff/screens/home/home.dart';
import 'package:evds_staff/screens/login/login.dart';
import 'package:evds_staff/screens/login/login_binding.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  static const initialRoute = AppRoutes.login;

  static final routes = [
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
      transition: Transition.zoom,
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeScreen(),
      transition: Transition.size,
    )
  ];
}
