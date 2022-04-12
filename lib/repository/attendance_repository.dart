import 'package:get/get.dart';
import 'package:valua_camera/enums/attendance_action.dart';
import 'package:valua_camera/models/check_attendance.dart';

abstract class AttendanceRepository {
  Future<dynamic> checkAttendance(String attendanceId, FormData formData);
  Future<CheckAttendance> updateAttendance(
      String attendanceId, AttendanceAction action);
}
