import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:valua_camera/models/assigned_exam_room.dart';
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
      child: Scaffold(
        appBar: AppBar(
          title: Text(_controller.examRoom.currentRoom.roomName),
          bottom: TabBar(
            controller: _controller.tabController,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 15,
            ),
            tabs: _controller.tabs,
          ),
        ),
        bottomNavigationBar: Obx(
          () => _controller.tabControllerIndex.value == 0
              ? Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 12.0,
                  ),
                  child: RoundButton(
                    height: 44,
                    width: double.infinity,
                    label: "Finish check in",
                    onPressed: () {
                      _showPasswordConfirmation(context);
                      // Get.toNamed(AppRoutes.dashboard);
                    },
                  ),
                )
              : const SizedBox(),
        ),
        body: TabBarView(
          controller: _controller.tabController,
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
                  Obx(
                    () => FutureBuilder<void>(
                      future: _controller.initializeControllerFuture.value,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return QrImage(
                            data: _controller.examRoom.currentRoom.roomId,
                            version: QrVersions.auto,
                            padding: const EdgeInsets.all(32.0),
                            size: MediaQuery.of(context).size.height / 2,
                          );
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      },
                    ),
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
    );
  }

  Widget _buildAttendanceScreen(
      BuildContext context, AssignedExamRoom assignedExamRoom) {
    final _controller = Get.find<CheckInController>();
    return SingleChildScrollView(
      physics: const ScrollPhysics(),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
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
                  expandedHeaderPadding:
                      const EdgeInsets.symmetric(vertical: 8.0),
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
                          final examinee = attendance.subjectExaminee.examinee;
                          return ListTile(
                            title: Text(examinee.fullName),
                            subtitle: Text(examinee.companyId),
                            leading: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  attendance.position
                                      .toString()
                                      .padLeft(2, '0'),
                                  style: const TextStyle(fontSize: 14),
                                  textAlign: TextAlign.start,
                                ),
                                const SizedBox(width: 10),
                                CachedCircleAvatar(
                                  imageUrl: examinee.imageUrl != null &&
                                          examinee.imageUrl!.isNotEmpty
                                      ? examinee.imageUrl.toString()
                                      : 'https://i.stack.imgur.com/34AD2.jpg',
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
        ],
      ),
    );
  }

  Future _showPasswordConfirmation(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final _controller = Get.find<CheckInController>();
    return showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      context: context,
      builder: (context) => SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Authorization required',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Form(
                      key: formKey,
                      child: TextFormField(
                        obscureText: true,
                        controller: _controller.passwordController,
                        decoration: const InputDecoration(
                          labelText: "Enter staff password",
                        ),
                        validator: RequiredValidator(
                          errorText: "Password is required",
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    RoundButton(
                      isLoading: _controller.isLoading.value,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          _controller.checkPassword();
                        }
                      },
                      height: 45,
                      width: double.infinity,
                      label: "Submit",
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
}
