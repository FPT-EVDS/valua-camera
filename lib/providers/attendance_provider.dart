import 'package:get/get_connect/http/src/multipart/form_data.dart';
import 'package:valua_camera/enums/attendance_action.dart';
import 'package:valua_camera/models/check_attendance.dart';
import 'package:valua_camera/providers/base_provider.dart';
import 'package:valua_camera/repository/attendance_repository.dart';

class AttendanceProvider extends BaseProvider implements AttendanceRepository {
  @override
  Future<dynamic> checkAttendance(
      String attendanceId, FormData formData) async {
    final response = await post("/attendances/check/$attendanceId", formData);
    if (response.status.hasError) {
      throw (response.body);
    }
    return response.body;
  }

  @override
  Future<CheckAttendance> updateAttendance(
      String attendanceId, AttendanceAction action) async {
    final response = await put("/attendances/$attendanceId", {}, query: {
      "operation": action == AttendanceAction.check ? "check" : "uncheck",
    });
    if (response.status.hasError) {
      throw (response.body);
    }
    return CheckAttendance.fromJson(response.body);
  }
}
