import 'package:json_annotation/json_annotation.dart';
import 'package:valua_camera/models/app_user.dart';
part 'qr_login_response.g.dart';

@JsonSerializable()
class QrLoginResponse {
  @JsonKey(name: "authenticationResponse")
  AppUser appUser;
  bool status;

  QrLoginResponse({
    required this.appUser,
    required this.status,
  });

  factory QrLoginResponse.fromJson(Map<String, dynamic> json) =>
      _$QrLoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$QrLoginResponseToJson(this);
}
