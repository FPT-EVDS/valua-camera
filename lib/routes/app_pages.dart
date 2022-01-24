import 'package:valua_staff/screens/attendance/attendance.dart';
import 'package:valua_staff/screens/dashboard/dashboard.dart';
import 'package:valua_staff/screens/login/login.dart';
import 'package:valua_staff/screens/main/main_screen.dart';
import 'package:get/get.dart';
import 'package:valua_staff/screens/report/incident.dart';

part 'app_routes.dart';

class AppPages {
  static const initialRoute = AppRoutes.login;

  static final routes = [
    GetPage(
      name: AppRoutes.login,
      page: () => LoginScreen(),
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
    ),
  ];
}
