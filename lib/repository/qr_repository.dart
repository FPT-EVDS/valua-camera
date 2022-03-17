import 'package:valua_camera/models/generated_qr.dart';

abstract class QRRepository {
  Future<GeneratedQR> generateQRData();
}
