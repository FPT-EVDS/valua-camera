import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:valua_camera/enums/attendance_action.dart';
import 'package:valua_camera/models/assigned_exam_room.dart';
import 'package:valua_camera/screens/attendance/attendance_controller.dart';
import 'package:valua_camera/widgets/attendance_pie_chart.dart';
import 'package:valua_camera/widgets/cached_circle_avatar.dart';
import 'package:valua_camera/utils/collections.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _controller = Get.find<AttendanceController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Attendance list"),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: _controller.assignedExamRoom.value,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              AssignedExamRoom data = snapshot.data;
              return _controller.isExpandedList.isNotEmpty
                  ? Obx(
                      () => _buildAttendanceScreen(
                        context,
                        data,
                      ),
                    )
                  : const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/images/not_found.svg",
                    height: 200,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    snapshot.error.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 13),
                  ),
                ],
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  Widget _buildAttendanceScreen(
      BuildContext context, AssignedExamRoom assignedExamRoom) {
    final _controller = Get.find<AttendanceController>();
    return SingleChildScrollView(
      physics: const ScrollPhysics(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AttendancePieChart(
            attended: _controller.attendedAttendances.value.toDouble(),
            unattended: (assignedExamRoom.totalAttendances -
                    _controller.attendedAttendances.value)
                .toDouble(),
          ),
          const SizedBox(height: 20),
          Obx(
            () => ExpansionPanelList(
              expandedHeaderPadding: const EdgeInsets.symmetric(vertical: 8.0),
              elevation: 2,
              expansionCallback: (int index, bool isExpanded) {
                _controller.isExpandedList[index] = !isExpanded;
              },
              children:
                  assignedExamRoom.examRooms.mapIndexed((index, examRoom) {
                return ExpansionPanel(
                  isExpanded: _controller.isExpandedList[index],
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return ListTile(
                      title: Text(
                        examRoom.examRoomName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                  body: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: examRoom.attendances.length,
                    padding: const EdgeInsets.all(8.0),
                    itemBuilder: (context, index) {
                      final attendance = examRoom.attendances[index];
                      final isFinished = attendance.finishTime != null &&
                          attendance.startTime != null;
                      return Slidable(
                        key: ValueKey(attendance.attendanceId),
                        startActionPane:
                            attendance.startTime != null && !isFinished
                                ? ActionPane(
                                    motion: const ScrollMotion(),
                                    children: [
                                      SlidableAction(
                                        onPressed: (context) {
                                          _controller.updateAttendanceStatus(
                                            attendance.attendanceId,
                                            AttendanceAction.finish,
                                          );
                                        },
                                        backgroundColor: Colors.teal,
                                        foregroundColor: Colors.white,
                                        icon: Icons.done,
                                        label: 'Finish',
                                      ),
                                    ],
                                  )
                                : null,
                        endActionPane: isFinished
                            ? null
                            : ActionPane(
                                motion: const ScrollMotion(),
                                children: attendance.startTime == null
                                    ? [
                                        SlidableAction(
                                          onPressed: (context) {
                                            _controller.updateAttendanceStatus(
                                              attendance.attendanceId,
                                              AttendanceAction.check,
                                            );
                                          },
                                          backgroundColor: Colors.green,
                                          foregroundColor: Colors.white,
                                          icon: Icons.check,
                                          label: 'Check',
                                        ),
                                      ]
                                    : [
                                        SlidableAction(
                                          onPressed: (context) {
                                            _controller.updateAttendanceStatus(
                                              attendance.attendanceId,
                                              AttendanceAction.uncheck,
                                            );
                                          },
                                          backgroundColor: Colors.red,
                                          foregroundColor: Colors.white,
                                          icon: Icons.close,
                                          label: 'Uncheck',
                                        ),
                                      ],
                              ),
                        child: ListTile(
                          title: Text(
                              attendance.subjectExaminee.examinee.fullName),
                          subtitle: Text(
                              attendance.subjectExaminee.examinee.companyId),
                          leading: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                attendance.position.toString().padLeft(2, '0'),
                                style: const TextStyle(fontSize: 14),
                                textAlign: TextAlign.start,
                              ),
                              const SizedBox(width: 10),
                              CachedCircleAvatar(
                                imageUrl: attendance
                                        .subjectExaminee.examinee.imageUrl ??
                                    'https://i.stack.imgur.com/34AD2.jpg',
                                radius: 24,
                              ),
                            ],
                          ),
                          trailing: isFinished
                              ? const Icon(
                                  CommunityMaterialIcons.check_circle,
                                  color: Colors.teal,
                                  size: 24.0,
                                )
                              : attendance.startTime != null
                                  ? const Icon(
                                      CommunityMaterialIcons.check_circle,
                                      color: Colors.green,
                                      size: 24.0,
                                    )
                                  : const Icon(
                                      CommunityMaterialIcons.close_circle,
                                      color: Colors.red,
                                      size: 24.0,
                                    ),
                        ),
                      );
                    },
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
