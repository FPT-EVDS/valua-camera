import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'package:valua_camera/constants/app.dart';
import 'package:valua_camera/models/assigned_exam_room.dart';

const socketUrl = AppConstant.apiUrl + "/websocket";

class CheckInController extends GetxController {
  late StompClient stompClient;
  final AssignedExamRoom examRoom = Get.arguments;
  final takenImage = Rx<XFile?>(null);
  late CameraController cameraController;
  late Future<void> initializeControllerFuture;
  final attendedAttendances = 0.obs;
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
    final cameras = await availableCameras();
    if (cameras.isNotEmpty) {
      // Get front camera
      CameraDescription cameraDescription =
          await getCamera(CameraLensDirection.front);
      cameraController =
          CameraController(cameraDescription, ResolutionPreset.high);
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

  void onSubscribeCallback(StompFrame stompFrame) {
    print(stompFrame);
    if (stompFrame.body != null) {
      try {
        final jsonData =
            jsonDecode(stompFrame.body.toString()) as Map<String, dynamic>;
        Fluttertoast.showToast(msg: jsonData.toString());
        print(jsonData);
      } catch (error) {
        Fluttertoast.showToast(
          msg: "Please scan again",
          backgroundColor: Colors.grey.shade700,
        );
      }
    }
  }

  void onConnect(StompFrame frame) async {
    final topic = '/${examRoom.currentRoom.roomId}';
    unsubscribeFn = stompClient.subscribe(
      destination: topic,
      callback: onSubscribeCallback,
    );
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }
}
