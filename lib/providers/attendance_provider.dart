import 'package:get/get_connect/http/src/multipart/form_data.dart';
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
}
