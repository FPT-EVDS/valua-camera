import 'package:get/get.dart';

abstract class AttendanceRepository {
  Future<dynamic> checkAttendance(String attendanceId, FormData formData);
}
