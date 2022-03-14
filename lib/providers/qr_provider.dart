import 'package:valua_camera/models/generated_qr.dart';
import 'package:valua_camera/providers/base_provider.dart';
import 'package:valua_camera/repository/qr_repository.dart';

class QRProvider extends BaseProvider implements QRRepository {
  @override
  Future<GeneratedQR> generateQRData() async {
    final response = await get("/qrcode/login");
    if (response.status.hasError) {
      throw (response.body);
    }
    return GeneratedQR.fromJson(response.body);
  }
}
