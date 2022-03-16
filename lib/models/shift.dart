import 'package:json_annotation/json_annotation.dart';
import 'package:valua_camera/enums/shift_status.dart';
import 'package:valua_camera/models/account_alternative.dart';

part 'shift.g.dart';

@JsonSerializable()
class Shift {
  String shiftId;
  String beginTime;
  String finishTime;
  AccountAlternative shiftManager;
  ShiftStatus status;

  Shift({
    required this.shiftId,
    required this.beginTime,
    required this.finishTime,
    required this.shiftManager,
    required this.status,
  });

  factory Shift.fromJson(Map<String, dynamic> json) => _$ShiftFromJson(json);
  Map<String, dynamic> toJson() => _$ShiftToJson(this);
}
