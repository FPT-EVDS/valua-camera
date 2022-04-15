import 'package:json_annotation/json_annotation.dart';
import 'package:valua_camera/models/attendance.dart';
import 'package:valua_camera/models/subject_semester.dart';

part 'exam_room.g.dart';

@JsonSerializable()
class ExamRoom {
  String examRoomId;
  String examRoomName;
  List<Attendance> attendances;
  int status;
  SubjectSemester subjectSemester;
  DateTime? startTime;
  DateTime? finishTime;
  DateTime createdDate;
  DateTime lastModifiedDate;

  ExamRoom({
    required this.examRoomId,
    required this.examRoomName,
    required this.attendances,
    required this.status,
    required this.subjectSemester,
    this.startTime,
    this.finishTime,
    required this.createdDate,
    required this.lastModifiedDate,
  });

  factory ExamRoom.fromJson(Map<String, dynamic> json) =>
      _$ExamRoomFromJson(json);
  Map<String, dynamic> toJson() => _$ExamRoomToJson(this);
}
