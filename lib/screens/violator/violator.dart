import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:valua_camera/models/attendance.dart';
import 'package:valua_camera/models/exam_room.dart';
import 'package:valua_camera/routes/app_pages.dart';
import 'package:valua_camera/screens/violator/violator_controller.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:get/get.dart';
import 'package:valua_camera/widgets/violator_list_title.dart';

class ViolatorScreen extends StatelessWidget {
  const ViolatorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _controller = Get.find<ViolatorController>();
    return Scaffold(
      appBar: AppBar(
          actions: <Widget>[
            IconButton(
              onPressed: () {},
              icon: Icon(
                CommunityMaterialIcons.magnify,
                color: Colors.black,
              ),
            ),
          ],
          leading: IconButton(
            icon: const Icon(CommunityMaterialIcons.chevron_left),
            onPressed: () {
              Get.back();
            },
          ),
          centerTitle: true,
          title: const Text(
            'Select violator',
          )),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: Obx(
                () => FutureBuilder(
                  future: _controller.assignedExamRoom.value,
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasData) {
                      ExamRoom data = snapshot.data;
                      final attendances = data.attendances;
                      if (attendances.isEmpty) {
                        return Text('Huy dep trai vip pro');
                      }
                      return ListView.builder(
                        itemCount: attendances.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              _controller
                                  .handleChangeViolator(attendances[index]);
                              Get.toNamed(
                                AppRoutes.regulation,
                                arguments: {
                                  "id": _controller.id,
                                  "imageUrl": _controller.imageUrl,
                                  "fullName": _controller.fullName,
                                  "pos": _controller.pos,
                                  "violatorId": _controller.violatorId,
                                  "examRoomId": data.examRoomId,
                                },
                              );
                            },
                            child: Card(
                              elevation: 1,
                              margin: const EdgeInsets.symmetric(
                                vertical: 8.0,
                                horizontal: 8.0,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: ViolatorListTile(
                                  title: attendances[index].examinee!.companyId,
                                  subtitle:
                                      attendances[index].examinee!.fullName,
                                  imageUrl:
                                      attendances[index].examinee!.imageUrl!,
                                  position:
                                      attendances[index].position.toString(),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/images/no_found.svg",
                            height: 180,
                          ),
                          const SizedBox(height: 15),
                          Text(
                            "There is no examinee in this room",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
