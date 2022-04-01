import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'package:valua_camera/constants/app.dart';
import 'package:valua_camera/models/assigned_exam_room.dart';
import 'package:valua_camera/models/current_attendance.dart';
import 'package:valua_camera/providers/attendance_provider.dart';
import 'package:valua_camera/providers/auth_provider.dart';
import 'package:valua_camera/repository/attendance_repository.dart';
import 'package:valua_camera/routes/app_pages.dart';
import 'package:valua_camera/screens/main/main_controller.dart';
import 'package:image/image.dart' as img;
import 'package:valua_camera/widgets/rich_text_item.dart';

const socketUrl = AppConstant.apiUrl + "/websocket";

class CheckInController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final isLoading = false.obs;
  late StompClient stompClient;
  late TextEditingController passwordController = TextEditingController();
  final AssignedExamRoom examRoom = Get.arguments;
  final currentAttendance = Rx<CurrentAttendance?>(null);
  final tabControllerIndex = 1.obs;
  late CameraController cameraController;
  final AttendanceRepository _attendanceProvider =
      Get.find<AttendanceProvider>();
  final AuthProvider _authProvider = Get.find<AuthProvider>();
  final MainController _mainController = Get.find<MainController>();
  final attendedAttendances = 0.obs;
  late Rx<AssignedExamRoom> assignedExamRoom;
  RxList<bool> isExpandedList = RxList<bool>();
  late dynamic unsubscribeFn;
  final List<Tab> tabs = [
    const Tab(text: ("Attendance")),
    const Tab(text: ("QR Checking"))
  ];
  late TabController tabController;

  Future<CameraDescription> getCamera(CameraLensDirection direction) async {
    return await availableCameras().then(
      (List<CameraDescription> cameras) => cameras.firstWhere(
        (CameraDescription camera) => camera.lensDirection == direction,
      ),
    );
  }

  @override
  void onInit() async {
    tabController = TabController(
      length: tabs.length,
      vsync: this,
      initialIndex: tabControllerIndex.value,
    );
    tabController.addListener(() {
      tabControllerIndex.value = tabController.index;
    });
    assignedExamRoom = examRoom.obs;
    final cameras = await availableCameras();
    if (cameras.isNotEmpty) {
      // Get front camera
      CameraDescription cameraDescription =
          await getCamera(CameraLensDirection.front);
      cameraController =
          CameraController(cameraDescription, ResolutionPreset.veryHigh);
      await cameraController.initialize();
      if (Platform.isAndroid) {
        await cameraController
            .lockCaptureOrientation(DeviceOrientation.portraitUp);
      }
    }
    stompClient = StompClient(
        config: StompConfig.SockJS(
      url: socketUrl,
      onConnect: onConnect,
      onWebSocketError: (p0) {
        Fluttertoast.showToast(
          msg: p0.toString(),
          backgroundColor: Colors.grey.shade700,
        );
      },
    ));
    stompClient.activate();
    isExpandedList.value =
        List.generate(examRoom.examRooms.length, (index) => true);
    for (var examRoom in examRoom.examRooms) {
      final examRoomAttendedAttendances = examRoom.attendances
          .where((attendance) => attendance.startTime != null)
          .toList()
          .length;
      attendedAttendances.value += examRoomAttendedAttendances;
    }
    super.onInit();
  }

  void onSubscribeCallback(StompFrame stompFrame) async {
    if (stompFrame.body != null) {
      try {
        final jsonData =
            jsonDecode(stompFrame.body.toString()) as Map<String, dynamic>;
        currentAttendance.value = CurrentAttendance.fromJson(jsonData);
        await handleCaptureImage();
      } catch (error) {
        showDialog(
          "An error occurred",
          error.toString(),
          false,
        );
      }
    }
  }

  void onConnect(StompFrame frame) async {
    final topic = '/qr/room/${examRoom.currentRoom.roomId}';
    unsubscribeFn = stompClient.subscribe(
      destination: topic,
      callback: onSubscribeCallback,
    );
  }

  Future<void> handleCaptureImage() async {
    final result = await Get.toNamed(
      AppRoutes.camera,
      arguments: cameraController,
    );
    if (result != null) {
      showLoadingDialog();
      XFile takenImage = result;
      final img.Image? capturedImage =
          img.decodeImage(await takenImage.readAsBytes());
      final img.Image orientedImage = img.bakeOrientation(capturedImage!);
      File imageFile = await File(takenImage.path)
          .writeAsBytes(img.encodeJpg(orientedImage));
      final FormData _formData = FormData({
        'image': MultipartFile(
          imageFile,
          filename: takenImage.name,
        ),
      });
      _attendanceProvider
          .checkAttendance(
        currentAttendance.value!.currentAttendance.attendanceId,
        _formData,
      )
          .then((data) {
        Get.back();
        if (data['currentAttendance'] != null) {
          final currentAttendance = CurrentAttendance.fromJson(data);
          final attendanceExamRoom =
              currentAttendance.currentAttendance.examRoom;
          final currentExamRoom = assignedExamRoom.value;
          // update state of current attendance start time
          currentExamRoom.examRooms
              .firstWhere((examRoom) =>
                  examRoom.examRoomId == attendanceExamRoom.examRoomId)
              .attendances
              .firstWhere((attendance) =>
                  attendance.attendanceId ==
                  currentAttendance.currentAttendance.attendanceId)
              .startTime = currentAttendance.currentAttendance.startTime;
          assignedExamRoom.value = currentExamRoom;
          attendedAttendances.value += 1;
          _mainController.assignedExamRoom.value =
              Future.value(currentExamRoom);
          showAttendanceDialog(currentAttendance);
        } else if (data['lastAttempt'] != null) {
          showDialog(
            "Failed",
            "Your face doesn't match. Please try again",
            false,
          );
        } else {
          showDialog(
            "Failed",
            data.toString(),
            false,
          );
        }
      }).catchError((error) {
        Get.back();
        showDialog(
          "Failed",
          error.toString(),
          false,
        );
      });
    } else {
      Fluttertoast.showToast(
        msg: "You haven't take your picture yet",
        backgroundColor: Colors.grey.shade700,
      );
    }
  }

  showAttendanceDialog(CurrentAttendance attendance) {
    final examinee = attendance.currentAttendance.subjectExaminee.examinee;
    // auto close duration
    final Timer _timer = Timer(const Duration(seconds: 8), () {
      Get.back();
    });
    return Get.defaultDialog(
      title: examinee.companyId,
      radius: 8,
      titleStyle: const TextStyle(fontSize: 20),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 96,
            backgroundImage: Image.network(
              attendance.currentAttendance.attempts.last.imageUrl,
              fit: BoxFit.cover,
            ).image,
          ),
          const SizedBox(height: 20),
          Text(examinee.fullName),
          const SizedBox(height: 10),
          RichTextItem(
            title: "Attended at: ",
            content: attendance.currentAttendance.startTime != null
                ? DateFormat('dd/MM/yyyy HH:mm').format(
                    attendance.currentAttendance.startTime!,
                  )
                : '',
          ),
          const SizedBox(height: 10),
          RichTextItem(
            title: "Seat position: ",
            content: attendance.currentAttendance.position.toString(),
          ),
        ],
      ),
    ).then((val) {
      if (_timer.isActive) {
        _timer.cancel();
      }
    });
  }

  showDialog(String title, String message, bool isSuccess) {
    // auto close duration
    final Timer _timer = Timer(const Duration(seconds: 5), () {
      Get.back();
    });
    return Get.defaultDialog(
      title: title,
      radius: 8,
      titleStyle: const TextStyle(fontSize: 20),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            isSuccess
                ? const Icon(
                    CommunityMaterialIcons.check_circle,
                    size: 72,
                    color: Colors.green,
                  )
                : const Icon(
                    CommunityMaterialIcons.close_circle,
                    size: 72,
                    color: Colors.red,
                  ),
            const SizedBox(height: 10),
            Text(
              message,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ).then((val) {
      if (_timer.isActive) {
        _timer.cancel();
      }
    });
  }

  showLoadingDialog() {
    return Get.defaultDialog(
      title: "Processing...",
      radius: 8,
      titleStyle: const TextStyle(fontSize: 20),
      content: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    passwordController.dispose();
    tabController.dispose();
    cameraController.dispose();
    super.dispose();
  }

  Future<void> checkPassword() async {
    isLoading.value = true;
    try {
      String password = passwordController.text;
      String message = await _authProvider.checkPassword(password);
      if (message == "Password is correct") {
        Get.offAllNamed(AppRoutes.dashboard);
      } else {
        throw Exception(message);
      }
    } catch (error) {
      Fluttertoast.showToast(
        msg: error.toString(),
        backgroundColor: Colors.grey.shade700,
      );
    } finally {
      passwordController.clear();
      isLoading.value = false;
    }
  }
}
