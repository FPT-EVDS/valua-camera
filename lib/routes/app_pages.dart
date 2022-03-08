import 'package:valua_camera/screens/attendance/attendance.dart';
import 'package:valua_camera/screens/dashboard/dashboard.dart';
import 'package:valua_camera/screens/incident/incident.dart';
import 'package:valua_camera/screens/incident/incident_binding.dart';
import 'package:valua_camera/screens/regulation/regulation.dart';
import 'package:valua_camera/screens/login/login.dart';
import 'package:valua_camera/screens/regulation/regulation_binding.dart';
import 'package:valua_camera/screens/report/report.dart';
import 'package:valua_camera/screens/report/report_binding.dart';
import 'package:valua_camera/screens/violator/violator.dart';
import 'package:valua_camera/screens/login/login_binding.dart';
import 'package:valua_camera/screens/main/main.dart';
import 'package:get/get.dart';
import 'package:valua_camera/screens/main/main_binding.dart';
import 'package:valua_camera/screens/violator/violator_binding.dart';

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
      page: () => IncidentScreen(),
      binding: IncidentBinding(),
    ),
    GetPage(
      name: AppRoutes.regulation,
      page: () => RegulationScreen(),
      binding: RegulationBinding(),
    ),
    GetPage(
      name: AppRoutes.violator,
      page: () => const ViolatorScreen(),
      binding: ViolatorBinding(),
    ),
    GetPage(
      name: AppRoutes.report,
      page: () => const ReportScreen(),
      binding: ReportBinding(),
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
