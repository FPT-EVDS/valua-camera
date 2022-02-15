import 'package:get_storage/get_storage.dart';
import 'package:valua_camera/constants/app.dart';
import 'package:valua_camera/models/report.dart';
import 'package:valua_camera/providers/base_provider.dart';
import 'package:valua_camera/repository/incident_repository.dart';

class IncidentProvider extends BaseProvider implements IncidentRepository {
  final GetStorage _storage = GetStorage(AppConstant.storageKey);

  @override
  Future<Report> submit(String description, String note) {
    // TODO: implement submit
    throw UnimplementedError();
  }
}
