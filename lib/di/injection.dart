import 'package:valua_staff/repository/auth_repository.dart';
import 'package:valua_staff/repository/shift_repository.dart';
import 'package:valua_staff/repository/exam_room_repository.dart';
import 'package:valua_staff/services/auth_service.dart';
import 'package:valua_staff/services/exam_room_service.dart';

class Injector {
  static final Injector _singleton = Injector._internal();

  factory Injector() {
    return _singleton;
  }

  Injector._internal();

  AuthRepository get authRepository => AuthService();

  ExamRoomRepository get examRoomRepository => new ExamRoomService();
}
