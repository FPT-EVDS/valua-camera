import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:valua_camera/models/assigned_exam_room.dart';
import 'package:valua_camera/routes/routes.dart';
import 'package:valua_camera/screens/check_in/check_in_controller.dart';
import 'package:valua_camera/utils/collections.dart';
import 'package:valua_camera/widgets/attendance_pie_chart.dart';
import 'package:valua_camera/widgets/cached_circle_avatar.dart';
import 'package:valua_camera/widgets/round_button.dart';

class CheckInScreen extends StatelessWidget {
  const CheckInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _controller = Get.find<CheckInController>();
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text(_controller.examRoom.currentRoom.roomName),
            bottom: const TabBar(
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              labelStyle: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
              tabs: [Tab(text: ("Attendance")), Tab(text: ("QR Checking"))],
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: RoundButton(
              height: 44,
              width: double.infinity,
              label: "Finish check in",
              onPressed: () {
                Get.toNamed(AppRoutes.dashboard);
              },
            ),
          ),
          body: TabBarView(
            children: [
              // Attendance screen
              Obx(
                () => _controller.isExpandedList.isNotEmpty
                    ? Obx(
                        () => _buildAttendanceScreen(
                          context,
                          _controller.assignedExamRoom.value,
                        ),
                      )
                    : const Center(child: CircularProgressIndicator()),
              ),
              // QR Checking screen
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    QrImage(
                      data: _controller.examRoom.currentRoom.roomId,
                      version: QrVersions.auto,
                      padding: const EdgeInsets.all(32.0),
                    ),
                    const Text(
                      "Scan QR with Examinee app to check in",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAttendanceScreen(
      BuildContext context, AssignedExamRoom assignedExamRoom) {
    final _controller = Get.find<CheckInController>();
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
                      return ListTile(
                        title:
                            Text(attendance.subjectExaminee.examinee.fullName),
                        subtitle:
                            Text(attendance.subjectExaminee.examinee.companyId),
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
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
