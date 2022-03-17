import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:valua_camera/models/modal_bottom_sheet_item.dart';
import 'package:valua_camera/routes/app_pages.dart';
import 'package:valua_camera/screens/dashboard/dashboard_controller.dart';
import 'package:valua_camera/widgets/card_button.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  Future _showReportTypeSelection(BuildContext context) {
    final _controller = Get.find<DashboardController>();
    final reportTypes = [
      ModalBottomSheetItem(
        title: "Exam regulation report",
        color: Colors.blue.shade500,
        iconData: CommunityMaterialIcons.file_document,
        onTap: () {
          Get.toNamed(
            AppRoutes.violation,
            arguments: _controller.assignedExamRoom.value,
          );
        },
      ),
      ModalBottomSheetItem(
        title: "Exam incident report",
        color: Colors.blue.shade900,
        iconData: CommunityMaterialIcons.file_document,
        onTap: () {
          Get.toNamed(
            AppRoutes.incident,
            arguments: _controller.assignedExamRoom.value,
          );
        },
      ),
    ];
    return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      context: context,
      builder: (context) => SizedBox(
        height: 200,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Choose type of report',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 20),
              ListView.separated(
                shrinkWrap: true,
                itemCount: reportTypes.length,
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: 10);
                },
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      // Close modal bottom sheet
                      Get.back();
                      reportTypes[index].onTap();
                    },
                    leading: CircleAvatar(
                      radius: 22,
                      backgroundColor: reportTypes[index].color,
                      child: Icon(
                        reportTypes[index].iconData,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(reportTypes[index].title),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _controller = Get.find<DashboardController>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Exam room dashboard',
        ),
      ),
      body: SafeArea(
        bottom: true,
        top: true,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: FutureBuilder(
            future: _controller.getAssignedExamRoom(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: <Widget>[
                    CardButton(
                      icon: CommunityMaterialIcons.google_classroom,
                      onPressed: () {
                        Get.toNamed(AppRoutes.attendance);
                      },
                      width: double.infinity,
                      label: 'Attendances',
                      detail: 'View attendances list',
                      height: 80,
                      color: Colors.white,
                      labelColor: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CardButton(
                      icon: CommunityMaterialIcons.file_document_multiple,
                      onPressed: () {},
                      width: double.infinity,
                      label: 'Reports',
                      detail: 'Manage submitted reports',
                      height: 80,
                      color: Colors.white,
                      labelColor: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
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
      floatingActionButton: Obx(
        () => Visibility(
          visible: _controller.assignedExamRoom.value != null,
          child: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () async {
              await _showReportTypeSelection(context);
            },
          ),
        ),
      ),
    );
  }
}
