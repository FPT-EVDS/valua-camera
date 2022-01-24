import 'package:json_annotation/json_annotation.dart';
import 'package:valua_staff/models/auth_user.dart';
import 'package:valua_staff/models/semester.dart';
part 'shift.g.dart';

@JsonSerializable()
class Shift {
  String shiftId;
  String beginTime;
  String finishTime;

  Shift({
    required this.shiftId,
    required this.beginTime,
    required this.finishTime,
  });

  factory Shift.fromJson(Map<String, dynamic> json) => _$ShiftFromJson(json);
  Map<String, dynamic> toJson() => _$ShiftToJson(this);
}
