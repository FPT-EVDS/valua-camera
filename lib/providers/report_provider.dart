import 'package:valua_camera/models/report_list.dart';
import 'package:valua_camera/providers/base_provider.dart';
import 'package:valua_camera/repository/report_repository.dart';

class ReportProvider extends BaseProvider implements ReportRepository {
  @override
  Future<ReportList> getReport() async {
    final response = await get("/reports");
    if (response.status.hasError) {
      return Future.error(response.statusText!);
    }
    return ReportList.fromJson(response.body);
  }
}
