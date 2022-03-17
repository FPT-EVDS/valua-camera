import 'package:json_annotation/json_annotation.dart';
part 'generated_qr.g.dart';

@JsonSerializable()
class GeneratedQR {
  QRData data;
  bool status;

  GeneratedQR({
    required this.data,
    required this.status,
  });

  factory GeneratedQR.fromJson(Map<String, dynamic> json) =>
      _$GeneratedQRFromJson(json);
  Map<String, dynamic> toJson() => _$GeneratedQRToJson(this);
}

@JsonSerializable()
class QRData {
  String token;

  QRData({
    required this.token,
  });

  factory QRData.fromJson(Map<String, dynamic> json) => _$QRDataFromJson(json);
  Map<String, dynamic> toJson() => _$QRDataToJson(this);
}
