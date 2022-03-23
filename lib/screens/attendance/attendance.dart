import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:valua_camera/enums/attendance_status.dart';
import 'package:valua_camera/models/assigned_exam_room.dart';
import 'package:valua_camera/models/attendance.dart';
import 'package:valua_camera/screens/attendance/attendance_controller.dart';
import 'package:valua_camera/widgets/attendance_pie_chart.dart';
import 'package:valua_camera/widgets/cached_circle_avatar.dart';

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
          future: _controller.getAssignedExamRoom(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              AssignedExamRoom data = snapshot.data;
              return _buildAttendanceScreen(
                context,
                data.examRooms[0].attendances,
              );
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
      BuildContext context, List<Attendance> attendances) {
    final attendedAttendances =
        attendances.where((element) => element.startTime != null).toList();
    return SingleChildScrollView(
      physics: const ScrollPhysics(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AttendancePieChart(
            attended: attendedAttendances.length.toDouble(),
            unattended:
                (attendances.length - attendedAttendances.length).toDouble(),
          ),
          const SizedBox(height: 20),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: attendances.length,
            padding: const EdgeInsets.all(8.0),
            itemBuilder: (context, index) {
              final attendance = attendances[index];
              return ListTile(
                title: Text(attendance.subjectExaminee.examinee.fullName),
                subtitle: Text(attendance.subjectExaminee.examinee.companyId),
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
                      imageUrl: attendance.subjectExaminee.examinee.imageUrl ??
                          'https://i.stack.imgur.com/34AD2.jpg',
                      radius: 24,
                    ),
                  ],
                ),
                trailing: attendance.startTime != null
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
              );
            },
          ),
        ],
      ),
    );
  }
}
