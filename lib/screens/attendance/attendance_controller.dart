import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:valua_camera/enums/attendance_action.dart';
import 'package:valua_camera/models/assigned_exam_room.dart';
import 'package:valua_camera/providers/attendance_provider.dart';
import 'package:valua_camera/providers/exam_room_provider.dart';
import 'package:valua_camera/repository/attendance_repository.dart';
import 'package:valua_camera/repository/exam_room_repository.dart';

class AttendanceController extends GetxController {
  final assignedExamRoom = Future<AssignedExamRoom?>.value().obs;
  final ExamRoomRepository _examRoomProvider = Get.find<ExamRoomProvider>();
  final AttendanceRepository _attendanceProvider =
      Get.find<AttendanceProvider>();
  final attendedAttendances = 0.obs;
  final finishedAttendances = 0.obs;
  RxList<bool> isExpandedList = RxList<bool>();

  Future<AssignedExamRoom> getAssignedExamRoom({DateTime? date}) async {
    try {
      final data = _examRoomProvider.loadExamRoom().then((value) {
        final tempExamRooms = value.examRooms;
        int attendedAttendances = 0;
        int finishedAttendances = 0;
        // Sort attendances by position when init
        for (int i = 0; i < tempExamRooms.length; i++) {
          final examRoom = tempExamRooms[i];
          examRoom.attendances.sort((a, b) => a.position.compareTo(b.position));
          final examRoomAttendedAttendances = examRoom.attendances
              .where((attendance) => attendance.startTime != null)
              .toList()
              .length;
          final examRoomFinishedAttendances = examRoom.attendances
              .where((attendance) =>
                  attendance.startTime != null && attendance.finishTime != null)
              .toList()
              .length;
          attendedAttendances += examRoomAttendedAttendances;
          finishedAttendances += examRoomFinishedAttendances;
        }
        this.attendedAttendances.value =
            attendedAttendances - finishedAttendances;
        this.finishedAttendances.value = finishedAttendances;
        value.examRooms = tempExamRooms;
        return value;
      });
      assignedExamRoom.value = data;
      return data;
    } catch (err) {
      throw Exception(err);
    }
  }

  void updateAttendanceStatus(
    String attendanceId,
    AttendanceAction action,
  ) async {
    try {
      int attendedAttendances = 0;
      int finishedAttendances = 0;
      final currentAttendance =
          await _attendanceProvider.updateAttendance(attendanceId, action);
      final attendanceExamRoom = currentAttendance.attendance.examRoom;
      final currentExamRoom = await assignedExamRoom.value;
      // update state of current attendance start time & finish time
      currentExamRoom!.examRooms
          // find exam room of examinee
          .firstWhere((examRoom) =>
              examRoom.examRoomId == attendanceExamRoom.examRoomId)
          .attendances
          // find examinee
          .firstWhere((attendance) =>
              attendance.attendanceId ==
              currentAttendance.attendance.attendanceId)
        ..startTime = currentAttendance.attendance.startTime
        ..finishTime = currentAttendance.attendance.finishTime;
      //Update attended attendances and finished attendances
      for (int i = 0; i < currentExamRoom.examRooms.length; i++) {
        final examRoom = currentExamRoom.examRooms[i];
        final examRoomAttendedAttendances = examRoom.attendances
            .where((attendance) => attendance.startTime != null)
            .toList()
            .length;
        final examRoomFinishedAttendances = examRoom.attendances
            .where((attendance) =>
                attendance.startTime != null && attendance.finishTime != null)
            .toList()
            .length;
        attendedAttendances += examRoomAttendedAttendances;
        finishedAttendances += examRoomFinishedAttendances;
      }
      this.attendedAttendances.value =
          attendedAttendances - finishedAttendances;
      this.finishedAttendances.value = finishedAttendances;
      assignedExamRoom.value = Future.value(currentExamRoom);
      Fluttertoast.showToast(
        msg: "Update attendance successfully",
        backgroundColor: Colors.grey.shade700,
      );
    } catch (error) {
      Fluttertoast.showToast(
        msg: error.toString(),
        backgroundColor: Colors.grey.shade700,
      );
    }
  }

  @override
  void onInit() {
    getAssignedExamRoom().then((value) {
      isExpandedList.value =
          List.generate(value.examRooms.length, (index) => true);
    });
    super.onInit();
  }
}
