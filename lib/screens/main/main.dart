import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:valua_camera/models/exam_room.dart';
import 'package:valua_camera/routes/routes.dart';
import 'package:valua_camera/screens/main/main_controller.dart';
import 'package:valua_camera/widgets/rich_text_item.dart';
import 'package:valua_camera/widgets/round_button.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _controller = Get.find<MainController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Exam room name",
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'Logout') {
                _controller.logout();
                Get.offAndToNamed(AppRoutes.login);
              }
            },
            itemBuilder: (BuildContext context) {
              return {'Logout'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: FutureBuilder(
              future: _controller.assignedExamRoom.value,
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData) {
                  ExamRoom data = snapshot.data;
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
                                DateTime.parse(data.shift.beginTime.toString()),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            // time
                            RichTextItem(
                              title: "Time: ",
                              content: "${DateFormat("HH:mm").format(
                                DateTime.parse(data.shift.beginTime.toString()),
                              )} - ${DateFormat("HH:mm").format(
                                DateTime.parse(
                                    data.shift.finishTime.toString()),
                              )}",
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            // room
                            RichTextItem(
                              title: "Room: ",
                              content: data.room.roomName,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            // subject
                            RichTextItem(
                              title: "Subject: ",
                              content: data.subject.subjectCode,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            // total examinees
                            RichTextItem(
                              title: "Total examinees: ",
                              content: data.attendances.length.toString(),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 16,
                          ),
                          child: RoundButton(
                            height: 45,
                            width: double.infinity,
                            color: Colors.blue,
                            label: "Start attendance checking",
                            onPressed: () {
                              _controller.logout();
                              Get.offAndToNamed(AppRoutes.login);
                            },
                          ),
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
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      RoundButton(
                        height: 45,
                        width: 300,
                        color: Colors.blue,
                        label: "Log out",
                        icon: const Icon(Icons.logout),
                        onPressed: () {
                          _controller.logout();
                          Get.offAndToNamed(AppRoutes.login);
                        },
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
    );
  }
}
