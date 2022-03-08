// ignore_for_file: prefer_const_constructors

import 'package:community_material_icon/community_material_icon.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valua_camera/models/report.dart';
import 'package:valua_camera/screens/report/report_controller.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _controller = Get.find<ReportController>();
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
            'Select report',
          )),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: _controller.getListReports(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    return SizedBox(
                      width: 300,
                      child: DropdownSearch<Report>(
                        mode: Mode.DIALOG,
                        popupTitle: const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            "Choose report",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        showSelectedItems: true,
                        itemAsString: (item) => item!.reportId,
                        items: snapshot.data,
                        dropdownSearchDecoration: const InputDecoration(
                          labelText: "Report",
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 12.0,
                            vertical: 4.0,
                          ),
                        ),
                        selectedItem: snapshot.data[0],
                      ),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
