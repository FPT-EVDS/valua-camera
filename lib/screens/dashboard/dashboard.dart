import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valua_camera/routes/app_pages.dart';
import 'package:valua_camera/widgets/card_button.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  Future _showReportTypeSelection(BuildContext context) {
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
                      const Text('Choose type of report',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 15)),
                      const SizedBox(height: 20),
                      ListTile(
                        onTap: () {},
                        leading: CircleAvatar(
                          radius: 22,
                          backgroundColor: Colors.blue[500],
                          child: const Icon(
                            CommunityMaterialIcons.file_document,
                            color: Colors.white,
                          ),
                        ),
                        title: const Text('Exam regulation report'),
                      ),
                      const SizedBox(height: 10),
                      ListTile(
                        onTap: () {},
                        leading: CircleAvatar(
                          radius: 22,
                          backgroundColor: Colors.blue[900],
                          child: const Icon(
                            CommunityMaterialIcons.file_document,
                            color: Colors.white,
                          ),
                        ),
                        title: const Text('Exam incident report'),
                      )
                    ],
                  )),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Exam room dashboard',
          )),
      body: SafeArea(
        bottom: true,
        top: true,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
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
                labelColor: Colors.blue,
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
                labelColor: Colors.blue,
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () async {
            await _showReportTypeSelection(context);
          }),
    );
  }
}
