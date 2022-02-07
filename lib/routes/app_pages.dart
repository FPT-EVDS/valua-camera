import 'package:valua_camera/screens/attendance/attendance.dart';
import 'package:valua_camera/screens/dashboard/dashboard.dart';
import 'package:valua_camera/screens/login/login.dart';
import 'package:valua_camera/screens/login/login_binding.dart';
import 'package:valua_camera/screens/main/main.dart';
import 'package:get/get.dart';
import 'package:valua_camera/screens/main/main_binding.dart';
import 'package:valua_camera/screens/report/incident.dart';

part 'app_routes.dart';

class AppPages {
  static const initialRoute = AppRoutes.login;

  static final routes = [
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.dashboard,
      page: () => const DashboardScreen(),
    ),
    GetPage(
      name: AppRoutes.incident,
      page: () => const IncidentScreen(),
    ),
    GetPage(
      name: AppRoutes.attendance,
      page: () => const AttendanceScreen(),
    ),
    GetPage(
      name: AppRoutes.main,
      page: () => const MainScreen(),
      binding: MainBinding(),
    ),
  ];
}
