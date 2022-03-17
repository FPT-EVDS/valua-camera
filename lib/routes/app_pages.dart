import 'package:valua_camera/screens/attendance/attendance.dart';
import 'package:valua_camera/screens/attendance/attendance_binding.dart';
import 'package:valua_camera/screens/check_in/check_in.dart';
import 'package:valua_camera/screens/check_in/check_in_binding.dart';
import 'package:valua_camera/screens/check_in_camera/check_in_camera.dart';
import 'package:valua_camera/screens/check_in_camera/check_in_camera_binding.dart';
import 'package:valua_camera/screens/dashboard/dashboard.dart';
import 'package:valua_camera/screens/dashboard/dashboard_binding.dart';
import 'package:valua_camera/screens/incident/incident.dart';
import 'package:valua_camera/screens/incident/incident_binding.dart';
import 'package:valua_camera/screens/login/login.dart';
import 'package:valua_camera/screens/login/login_binding.dart';
import 'package:valua_camera/screens/main/main.dart';
import 'package:get/get.dart';
import 'package:valua_camera/screens/main/main_binding.dart';
import 'package:valua_camera/screens/violation/violation.dart';
import 'package:valua_camera/screens/violation/violation_binding.dart';

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
      binding: DashboardBinding(),
    ),
    GetPage(
      name: AppRoutes.checkIn,
      page: () => const CheckInScreen(),
      binding: CheckInBinding(),
    ),
    GetPage(
      name: AppRoutes.incident,
      page: () => const IncidentScreen(),
      binding: IncidentBinding(),
    ),
    GetPage(
      name: AppRoutes.violation,
      page: () => const ViolationScreen(),
      binding: ViolationBinding(),
    ),
    GetPage(
      name: AppRoutes.attendance,
      page: () => const AttendanceScreen(),
      binding: AttendanceBinding(),
    ),
    GetPage(
      name: AppRoutes.camera,
      page: () => const CheckInCameraScreen(),
      binding: CheckInCameraBinding(),
      fullscreenDialog: true,
    ),
    GetPage(
      name: AppRoutes.main,
      page: () => const MainScreen(),
      binding: MainBinding(),
    ),
  ];
}
