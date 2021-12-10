import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:valua_staff/widgets/custom_list_tile.dart';
import 'package:valua_staff/widgets/header_attendance.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ChartType? _chartType = ChartType.ring;

    final dataMap = <String, double>{
      "Attended": 4,
      "Unattended": 3,
    };
    final colorList = <Color>[
      const Color.fromRGBO(76, 175, 80, 80),
      const Color.fromRGBO(244, 105, 54, 80),
    ];
    bool _showChartValuesOutside = true;
    bool _showLegendsInRow = true;
    bool _showCenterText = true;
    double? _ringStrokeWidth = 30;
    bool _showChartValueBackground = false;

    LegendPosition? _legendPosition = LegendPosition.bottom;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const HeaderAttendance(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              PieChart(
                ringStrokeWidth: _ringStrokeWidth,
                chartType: _chartType,
                // ignore: dead_code
                centerText: _showCenterText ? "7" : null,
                chartRadius: MediaQuery.of(context).size.width / 2.2 > 300
                    ? 300
                    : MediaQuery.of(context).size.width / 2.2,
                dataMap: dataMap,
                animationDuration: const Duration(milliseconds: 800),
                colorList: colorList,
                legendOptions: LegendOptions(
                  legendPosition: _legendPosition,
                  showLegendsInRow: _showLegendsInRow,
                  legendTextStyle: const TextStyle(
                    fontWeight: FontWeight.w300,
                  ),
                ),
                chartValuesOptions: ChartValuesOptions(
                  showChartValueBackground: _showChartValueBackground,
                  showChartValuesOutside: _showChartValuesOutside,
                  decimalPlaces: 0,
                  chartValueStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    backgroundColor: Colors.transparent,
                    fontSize: 22,
                  ),
                ),
              ),
              Column(
                children: [
                  CustomListTile(
                    attended: true,
                    imageUrl: "https://picsum.photos/200",
                    leadingNumber: 1,
                    subtitle: "Nguyen Huu Huy",
                    title: "SE140380",
                  ),
                  CustomListTile(
                    attended: false,
                    imageUrl: "https://picsum.photos/200",
                    leadingNumber: 2,
                    subtitle: "Tran Cam Long",
                    title: "SE140312",
                  ),
                  CustomListTile(
                    attended: true,
                    imageUrl: "https://picsum.photos/200",
                    leadingNumber: 3,
                    subtitle: "Ngo Tan Duc",
                    title: "SE140360",
                  ),
                  CustomListTile(
                    attended: false,
                    imageUrl: "https://picsum.photos/200",
                    leadingNumber: 4,
                    subtitle: "Nguyen Thi Kim Hang",
                    title: "SE140388",
                  ),
                  CustomListTile(
                    attended: true,
                    imageUrl: "https://picsum.photos/200",
                    leadingNumber: 5,
                    subtitle: "Hua Vinh Khang",
                    title: "SE140399",
                  ),
                  CustomListTile(
                    attended: false,
                    imageUrl: "https://picsum.photos/200",
                    leadingNumber: 6,
                    subtitle: "Ngo Vinh Khang",
                    title: "SE140209",
                  ),
                  CustomListTile(
                    attended: true,
                    imageUrl: "https://picsum.photos/200",
                    leadingNumber: 7,
                    subtitle: "Lam Hau Huong",
                    title: "SE140129",
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
