part of 'app_pages.dart';

abstract class AppRoutes {
  static const main = '/';
  static const login = '/login';
  static const home = '/home';
  static const shift = '/shift';
  static const position = '/position';
  static const createViolation = '/violation/create';
  static const confirmViolation = '/violation/confirm';
  static const detailShift = '/shift/detail';
  static const detailViolation = '/violation/detail';
  static const detailEvidence = '/evidence/detail';
  static const shiftViolation = '/violation/:id';
  static const notification = '/notification';
  static const detailProfile = '/profile/detail';
  static const changePassword = '/password/change';
}
