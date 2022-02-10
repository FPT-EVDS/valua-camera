import 'dart:async';

import 'package:camera/camera.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:valua_camera/enums/attendance_status.dart';
import 'package:valua_camera/models/attendance.dart';
import 'package:valua_camera/screens/check_in/check_in_controller.dart';
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
                    const SizedBox(height: 20),
                    RoundButton(
                      label: "Simulate check in",
                      onPressed: () async {
                        await showCheckInDialog(
                          context,
                          _controller.examRoom.attendances[0],
                        );
                      },
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

  showCheckInDialog(BuildContext context, Attendance attendance) async {
    final _controller = Get.find<CheckInController>();
    const double previewAspectRatio = 1;
    // show the dialog
    return await showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            // CachedCircleAvatar(
            //   imageUrl: attendance.examinee.imageUrl ??
            //       'https://i.stack.imgur.com/34AD2.jpg',
            //   radius: 60,
            // ),
            FutureBuilder<void>(
              future: _controller.initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  // If the Future is complete, display the preview.
                  return SizedBox(
                    height: 420,
                    child: AspectRatio(
                      aspectRatio: 1 / previewAspectRatio,
                      child: ClipOval(
                        child: Transform.scale(
                          scale:
                              _controller.cameraController.value.aspectRatio /
                                  previewAspectRatio,
                          child: Center(
                            child: CameraPreview(_controller.cameraController),
                          ),
                        ),
                      ),
                    ),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
            const SizedBox(height: 20),
            Text(
                "${attendance.examinee.fullName} - ${attendance.examinee.companyId}"),
            // const SizedBox(height: 10),
            // const RichTextItem(
            //   title: "Attended at: ",
            //   content: "23/08/2021 16:40",
            // ),
            // const SizedBox(height: 10),
            // RichTextItem(
            //   title: "Seat position: ",
            //   content: "${attendance.position}",
            // ),
            // const SizedBox(height: 10),
            RoundButton(
              onPressed: () async {
                try {
                  // Ensure camera initialization
                  await _controller.initializeControllerFuture;
                  // Take picture automatically after 5 second
                  Timer(const Duration(seconds: 5), () async {
                    final image =
                        await _controller.cameraController.takePicture();
                    _controller.takenImage.value = image;
                    Fluttertoast.showToast(msg: "Picture taken");
                  });
                } catch (e) {
                  print(e);
                }
              },
              label: "Take a picture manually",
            ),
          ],
        ),
      ),
    );
  }
}
