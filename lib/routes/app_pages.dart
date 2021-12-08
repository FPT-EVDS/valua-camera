import 'package:evds_staff/screens/confirm_violation/confirm_violation.dart';
import 'package:evds_staff/screens/create_violation/create_violation.dart';
import 'package:evds_staff/screens/detail_evidence/detail_evidence.dart';
import 'package:evds_staff/screens/detail_evidence/detail_evidence_binding.dart';
import 'package:evds_staff/screens/detail_profile/detail_profile.dart';
import 'package:evds_staff/screens/detail_profile/detail_profile_binding.dart';
import 'package:evds_staff/screens/detail_shift/detail_shift.dart';
import 'package:evds_staff/screens/detail_violation/detail_violation.dart';
import 'package:evds_staff/screens/detail_violation/detail_violation_binding.dart';
import 'package:evds_staff/screens/home/home.dart';
import 'package:evds_staff/screens/login/login.dart';
import 'package:evds_staff/screens/login/login_binding.dart';
import 'package:evds_staff/screens/main/main_screen.dart';
import 'package:evds_staff/screens/main/main_binding.dart';
import 'package:evds_staff/screens/position/position.dart';
import 'package:evds_staff/screens/reset_password/reset_password.dart';
import 'package:evds_staff/screens/shift/shift.dart';
import 'package:evds_staff/screens/shift/shift_binding.dart';
import 'package:evds_staff/screens/shift_violation/shift_violation.dart';
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
      name: AppRoutes.shift,
      page: () => const ShiftScreen(),
      binding: ShiftBinding(),
    ),
    GetPage(
      name: AppRoutes.detailShift,
      page: () => const DetailShiftScreen(),
    ),
    GetPage(
      name: AppRoutes.detailProfile,
      page: () => const DetailProfileScreen(),
      binding: DetailProfileBinding(),
    ),
    GetPage(
      name: AppRoutes.detailViolation,
      page: () => const DetailViolationScreen(),
      binding: DetailViolationBinding(),
    ),
    GetPage(
      name: AppRoutes.detailEvidence,
      page: () => const DetailEvidenceScreen(),
      binding: DetailEvidenceBinding(),
    ),
    GetPage(
      name: AppRoutes.position,
      page: () => const PositionScreen(),
    ),
    GetPage(
      name: AppRoutes.createViolation,
      page: () => const CreateViolationScreen(),
    ),
    GetPage(
      name: AppRoutes.confirmViolation,
      page: () => const ConfirmViolationScreen(),
    ),
    GetPage(
      name: AppRoutes.shiftViolation,
      page: () => const ShiftViolationScreen(),
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
