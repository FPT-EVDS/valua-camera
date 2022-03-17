import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:valua_camera/enums/report_type.dart';
import 'package:valua_camera/models/report_overview.dart';
import 'package:valua_camera/screens/report/report_controller.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({Key? key}) : super(key: key);

  Widget _generateListItem(Report report) {
    DateFormat _formatter = DateFormat("dd/MM/yyyy HH:mm");
    bool isIncident = report.reportType == ReportType.incident;
    return ListTile(
      title: Text(isIncident ? "Incident report" : "Violation report"),
      leading: CircleAvatar(
        radius: 22,
        backgroundColor: isIncident ? Colors.blue[900] : Colors.blue,
        child: Icon(
          isIncident
              ? CommunityMaterialIcons.alert
              : CommunityMaterialIcons.account_alert,
          color: Colors.white,
        ),
      ),
      onTap: () {
        isIncident
            ? Get.toNamed("/incident/${report.reportId}")
            : Get.toNamed("/violation/${report.reportId}");
      },
      subtitle: Text("Created at: ${_formatter.format(report.createdDate)}"),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _controller = Get.find<ReportController>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Manage reports',
        ),
      ),
      body: SafeArea(
        bottom: true,
        top: true,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder(
            future: _controller.getReportOverview(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                final ReportOverview overview = snapshot.data;
                // FIXME: get reports of all exam rooms
                if (overview.reportsInExamRooms.isNotEmpty) {
                  final reportsInExamRoom = overview.reportsInExamRooms[0];
                  return ListView.separated(
                    itemBuilder: (context, index) => _generateListItem(
                      reportsInExamRoom.reports[index],
                    ),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 10),
                    itemCount: reportsInExamRoom.reports.length,
                  );
                }
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/images/report.svg",
                        height: 200,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "No reports available",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                  ),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}
