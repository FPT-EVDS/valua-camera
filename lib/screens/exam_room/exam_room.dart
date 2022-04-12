import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:valua_camera/models/assigned_exam_room.dart';
import 'package:valua_camera/screens/exam_room/exam_room_controller.dart';
import 'package:valua_camera/widgets/rich_text_item.dart';

class ExamRoomScreen extends StatelessWidget {
  const ExamRoomScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _controller = Get.find<ExamRoomController>();
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(
            _controller.examRoomName.value.isNotEmpty
                ? _controller.examRoomName.value
                : "Exam room name",
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Obx(
              () => FutureBuilder(
                future: _controller.assignedExamRoom.value,
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    AssignedExamRoom data = snapshot.data;
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: <Widget>[
                              SizedBox(
                                width: 152,
                                height: 152,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: const Icon(
                                    CommunityMaterialIcons.google_classroom,
                                    size: 64,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              // date
                              RichTextItem(
                                title: "Date: ",
                                content: DateFormat('dd/MM/yyyy').format(
                                  DateTime.parse(data.currentShift.beginTime
                                          .toString())
                                      .toLocal(),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              // time
                              RichTextItem(
                                title: "Time: ",
                                content: "${DateFormat("HH:mm").format(
                                  DateTime.parse(data.currentShift.beginTime
                                          .toString())
                                      .toLocal(),
                                )} - ${DateFormat("HH:mm").format(
                                  DateTime.parse(data.currentShift.finishTime
                                          .toString())
                                      .toLocal(),
                                )}",
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              // room
                              RichTextItem(
                                title: "Room: ",
                                content: data.currentRoom.roomName,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              // subject
                              Obx(
                                () => RichTextItem(
                                  title: "Subject: ",
                                  content: _controller.subjectsMessage.value,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              // total examinees
                              Obx(
                                () => RichTextItem(
                                  title: "Total examinees: ",
                                  content: _controller.totalExaminees.value
                                      .toString(),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              // total examinees
                              Obx(
                                () => RichTextItem(
                                  textAlign: TextAlign.center,
                                  title: "Allowed tools: ",
                                  content: _controller.toolsMessage.value,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
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
          ),
        ),
      ),
    );
  }
}
