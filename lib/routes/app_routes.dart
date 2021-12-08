part of 'app_pages.dart';

abstract class AppRoutes {
  static const main = '/';
  static const login = '/login';
  static const home = '/home';
  static const shift = '/shift';
  static const detailShift = '/shift/detail';
  static const detailViolation = '/violation/detail';
  static const shiftViolation = '/violation/:id';
  static const notification = '/notification';
  static const detailProfile = '/profile/detail';
  static const resetPassword = '/password/reset';
}
