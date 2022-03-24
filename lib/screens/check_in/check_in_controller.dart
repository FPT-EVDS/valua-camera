import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'package:valua_camera/constants/app.dart';
import 'package:valua_camera/models/assigned_exam_room.dart';
import 'package:valua_camera/models/current_attendance.dart';
import 'package:valua_camera/providers/attendance_provider.dart';
import 'package:valua_camera/repository/attendance_repository.dart';
import 'package:valua_camera/routes/app_pages.dart';
import 'package:valua_camera/screens/main/main_controller.dart';
import 'package:image/image.dart' as img;

const socketUrl = AppConstant.apiUrl + "/websocket";

class CheckInController extends GetxController {
  late StompClient stompClient;
  final AssignedExamRoom examRoom = Get.arguments;
  final currentAttendance = Rx<CurrentAttendance?>(null);
  late CameraController cameraController;
  late Future<void> initializeControllerFuture;
  final AttendanceRepository _attendanceProvider =
      Get.find<AttendanceProvider>();
  final MainController _mainController = Get.find<MainController>();
  final attendedAttendances = 0.obs;
  late Rx<AssignedExamRoom> assignedExamRoom;
  RxList<bool> isExpandedList = RxList<bool>();
  late dynamic unsubscribeFn;

  Future<CameraDescription> getCamera(CameraLensDirection direction) async {
    return await availableCameras().then(
      (List<CameraDescription> cameras) => cameras.firstWhere(
        (CameraDescription camera) => camera.lensDirection == direction,
      ),
    );
  }

  @override
  void onInit() async {
    assignedExamRoom = examRoom.obs;
    final cameras = await availableCameras();
    if (cameras.isNotEmpty) {
      // Get front camera
      CameraDescription cameraDescription =
          await getCamera(CameraLensDirection.front);
      cameraController =
          CameraController(cameraDescription, ResolutionPreset.veryHigh);
      initializeControllerFuture = cameraController.initialize();
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
        Fluttertoast.showToast(
          msg: "Please scan again",
          backgroundColor: Colors.grey.shade700,
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
      final data = await _attendanceProvider.checkAttendance(
        currentAttendance.value!.currentAttendance.attendanceId,
        _formData,
      );
      // success check
      if (data['currentAttendance'] != null) {
        final currentAttendance = CurrentAttendance.fromJson(data);
        final attendanceExamRoom = currentAttendance.currentAttendance.examRoom;
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
        _mainController.assignedExamRoom.value = Future(() => currentExamRoom);
        showDialog(
          "Success",
          "${currentAttendance.currentAttendance.examinee.companyId} checked successfully",
          true,
        );
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
    } else {
      Fluttertoast.showToast(
        msg: "You haven't take your picture yet",
        backgroundColor: Colors.grey.shade700,
      );
    }
  }

  showDialog(String title, String message, bool isSuccess) {
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
    );
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }
}
