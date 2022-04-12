part of 'app_pages.dart';

abstract class AppRoutes {
  static const main = '/';
  static const checkIn = '/checkin';
  static const login = '/login';
  static const home = '/home';
  static const dashboard = '/dashboard';
  static const incident = '/incident';
  static const detailIncident = '/incident/:id';
  static const violation = '/violation';
  static const detailViolation = '/violation/:id';
  static const report = '/report';
  static const camera = '/camera';
  static const examRoom = '/exam-room';
  static const attendance = '/attendance';
}
