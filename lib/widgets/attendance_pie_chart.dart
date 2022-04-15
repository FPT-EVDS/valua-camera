import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'indicator.dart';

class AttendancePieChart extends StatelessWidget {
  const AttendancePieChart({
    Key? key,
    required this.attended,
    required this.unattended,
    this.finished,
  }) : super(key: key);

  final double attended;
  final double unattended;
  final double? finished;

  @override
  Widget build(BuildContext context) {
    List<double> section = finished != null
        ? [attended, unattended, finished!]
        : [attended, unattended];
    return SizedBox(
      height: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Stack(
              children: [
                PieChart(
                  PieChartData(
                    borderData: FlBorderData(
                      show: false,
                    ),
                    sectionsSpace: 0,
                    centerSpaceRadius: 60,
                    sections: showingSections(section),
                  ),
                ),
                Center(
                  child: Text(
                    (attended + unattended + (finished ?? 0))
                        .toStringAsFixed(0),
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Indicator(
                color: Colors.green[500],
                text: 'Attended',
                isSquare: true,
                size: 12,
              ),
              const SizedBox(
                width: 20,
              ),
              Indicator(
                color: Colors.red[500],
                text: 'Unattended',
                isSquare: true,
                size: 12,
              ),
              finished != null
                  ? Row(
                      children: const [
                        SizedBox(
                          width: 20,
                        ),
                        Indicator(
                          color: Colors.blue,
                          text: 'Finished',
                          isSquare: true,
                          size: 12,
                        ),
                      ],
                    )
                  : const SizedBox(),
            ],
          ),
          const SizedBox(
            width: 28,
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections(List<double> data) {
    const radius = 40.0;
    const fontSize = 16.0;
    final pieChartSectionData = [
      PieChartSectionData(
        color: Colors.green[500],
        value: data[0],
        title: (data[1] > 0 || (finished != null && finished! > 0))
            ? data[0].toStringAsFixed(0)
            : '',
        radius: radius,
        titleStyle: const TextStyle(
          fontSize: fontSize,
          color: Colors.white,
        ),
      ),
      PieChartSectionData(
        color: Colors.red[500],
        value: data[1],
        title: (data[0] > 0 || (finished != null && finished! > 0))
            ? data[1].toStringAsFixed(0)
            : '',
        radius: radius,
        titleStyle: const TextStyle(
          fontSize: fontSize,
          color: Colors.white,
        ),
      ),
    ];
    if (finished != null) {
      pieChartSectionData.add(PieChartSectionData(
        color: Colors.blue,
        value: data[2],
        title: (data[0] > 0 || data[1] > 0) ? data[2].toStringAsFixed(0) : '',
        radius: radius,
        titleStyle: const TextStyle(
          fontSize: fontSize,
          color: Colors.white,
        ),
      ));
    }
    return pieChartSectionData;
  }
}
