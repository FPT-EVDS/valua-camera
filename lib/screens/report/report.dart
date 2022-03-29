import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:valua_camera/enums/report_type.dart';
import 'package:valua_camera/models/report_overview.dart';
import 'package:valua_camera/screens/report/report_controller.dart';
import 'package:valua_camera/utils/collections.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({Key? key}) : super(key: key);

  Widget _generateListItem(Report report) {
    DateFormat _formatter = DateFormat("dd/MM/yyyy HH:mm");
    bool isIncident = report.reportType == ReportType.incident;
    bool isResolved = report.solution != null;
    return ListTile(
      title: Text(isIncident ? "Incident report" : "Violation report"),
      leading: CircleAvatar(
        radius: 22,
        backgroundColor: isResolved
            ? Colors.green
            : isIncident
                ? Colors.blue[900]
                : Colors.blue,
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
      body: SingleChildScrollView(
        child: SafeArea(
          bottom: true,
          top: true,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FutureBuilder(
              future: _controller.getReportOverview(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData) {
                  final ReportOverview overview = snapshot.data;
                  if (overview.reportsInExamRooms.isNotEmpty) {
                    return Obx(() => ExpansionPanelList(
                        expandedHeaderPadding:
                            const EdgeInsets.symmetric(vertical: 8.0),
                        elevation: 2,
                        expansionCallback: (int index, bool isExpanded) {
                          _controller.isExpandedList[index] = !isExpanded;
                        },
                        children: overview.reportsInExamRooms.mapIndexed(
                          (index, value) {
                            final reportsInExamRoom =
                                overview.reportsInExamRooms[index];
                            return ExpansionPanel(
                              isExpanded: _controller.isExpandedList[index],
                              headerBuilder:
                                  (BuildContext context, bool isExpanded) {
                                return ListTile(
                                  title: Text(
                                    reportsInExamRoom.examRoom.examRoomName,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                );
                              },
                              body: ListView.separated(
                                shrinkWrap: true,
                                itemBuilder: (context, index) =>
                                    _generateListItem(
                                  reportsInExamRoom.reports[index],
                                ),
                                separatorBuilder: (context, index) =>
                                    const SizedBox(height: 10),
                                itemCount: reportsInExamRoom.reports.length,
                              ),
                            );
                          },
                        ).toList()));
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
      ),
    );
  }
}
