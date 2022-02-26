import 'package:json_annotation/json_annotation.dart';
import 'package:valua_camera/models/account_alternative.dart';

part 'shift.g.dart';

@JsonSerializable()
class Shift {
  String shiftId;
  String beginTime;
  String finishTime;
  AccountAlternative shiftManager;

  Shift({
    required this.shiftId,
    required this.beginTime,
    required this.finishTime,
    required this.shiftManager,
  });

  factory Shift.fromJson(Map<String, dynamic> json) => _$ShiftFromJson(json);
  Map<String, dynamic> toJson() => _$ShiftToJson(this);
}
