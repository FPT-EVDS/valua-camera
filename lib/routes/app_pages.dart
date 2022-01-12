import 'package:valua_staff/screens/attendance/attendance.dart';
import 'package:valua_staff/screens/dashboard/dashboard.dart';
import 'package:valua_staff/screens/login/login.dart';
import 'package:valua_staff/screens/login/login_binding.dart';
import 'package:valua_staff/screens/main/main_binding.dart';
import 'package:valua_staff/screens/main/main_screen.dart';
import 'package:get/get.dart';
import 'package:valua_staff/screens/report/incident.dart';

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
      name: AppRoutes.dashboard,
      page: () => const DashboardScreen(),
    ),
    GetPage(
      name: AppRoutes.incident,
      page: () => const IncidentScreen(),
    ),
    GetPage(
<<<<<<< HEAD
      name: AppRoutes.attendance,
      page: () => const AttendanceScreen(),
=======
      name: AppRoutes.detailShift,
      page: () => const DetailShiftScreen(),
    ),
    GetPage(
      name: AppRoutes.detailProfile,
      page: () => const DetailProfileScreen(),
      binding: DetailProfileBinding(),
    ),
    GetPage(
      name: AppRoutes.changePassword,
      page: () => const ChangePasswordScreen(),
      binding: ChangePasswordBinding(),
>>>>>>> 71e6696b1c463261fc7c9c044ce0de68c636f558
    ),
    GetPage(
      name: AppRoutes.main,
      page: () => const MainScreen(),
      binding: MainBinding(),
    ),
  ];
}
