import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:valua_camera/enums/attendance_status.dart';
import 'package:valua_camera/models/attendance.dart';
import 'package:valua_camera/screens/check_in/check_in_controller.dart';
import 'package:valua_camera/widgets/attendance_pie_chart.dart';
import 'package:valua_camera/widgets/cached_circle_avatar.dart';

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
            title: Text(_controller.examRoom.examRoomName),
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
          body: TabBarView(
            children: [
              // Attendance screen
              _buildAttendanceScreen(context, _controller.examRoom.attendances),
              // QR Checking screen
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    QrImage(
                      data: _controller.examRoom.examRoomId,
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
      BuildContext context, List<Attendance> attendances) {
    final attendedAttendances = attendances
        .where((element) => element.status == AttendanceStatus.present)
        .toList();
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
                title: Text(attendance.examinee.companyId),
                subtitle: Text(attendance.examinee.fullName),
                leading: CachedCircleAvatar(
                  imageUrl: attendance.examinee.imageUrl ??
                      'https://i.stack.imgur.com/34AD2.jpg',
                  radius: 24,
                ),
                trailing: attendance.status == AttendanceStatus.present
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
