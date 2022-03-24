import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:valua_camera/models/assigned_exam_room.dart';
import 'package:valua_camera/routes/routes.dart';
import 'package:valua_camera/screens/check_in/check_in_controller.dart';
import 'package:valua_camera/widgets/attendance_pie_chart.dart';
import 'package:valua_camera/widgets/cached_circle_avatar.dart';
import 'package:valua_camera/widgets/rich_text_item.dart';
import 'package:valua_camera/widgets/round_button.dart';
import 'package:valua_camera/utils/collections.dart';

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
          body: TabBarView(
            children: [
              // Attendance screen
              Obx(
                () => _controller.isExpandedList.isNotEmpty
                    ? _buildAttendanceScreen(
                        context,
                        _controller.examRoom,
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
                    const SizedBox(height: 20),
                    RoundButton(
                      label: "Simulate check in",
                      onPressed: () async {
                        final result = await Get.toNamed(
                          AppRoutes.camera,
                          arguments: _controller.cameraController,
                        );
                        _controller.takenImage.value = result;
                        if (_controller.takenImage.value != null) {
                          showAlertDialog(
                            context,
                            _controller.takenImage.value,
                          );
                        }
                      },
                    ),
                    RoundButton(
                      label: "Test popup",
                      onPressed: () async {
                        if (_controller.takenImage.value != null) {
                          showAlertDialog(
                              context, _controller.takenImage.value);
                        }
                      },
                    ),
                    RoundButton(
                      label: "To exam room dashboard",
                      onPressed: () async {
                        Get.toNamed(AppRoutes.dashboard);
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

  showAlertDialog(BuildContext context, XFile? xFile) {
    late Timer _timer;

    // Create AlertDialog
    AlertDialog dialog = AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
      ),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 96,
            backgroundImage: Image.file(
              File(xFile!.path.toString()),
              fit: BoxFit.cover,
            ).image,
          ),
          const SizedBox(height: 20),
          const Text("Nguyen Huu Huy - SE140380"),
          const SizedBox(height: 10),
          RichTextItem(
            title: "Attended at: ",
            content: DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now()),
          ),
          const SizedBox(height: 10),
          const RichTextItem(title: "Seat position: ", content: "02"),
        ],
      ),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        _timer = Timer(const Duration(seconds: 7), () {
          Get.back();
        });
        return dialog;
      },
    ).then((val) {
      if (_timer.isActive) {
        _timer.cancel();
      }
    });
  }
}
