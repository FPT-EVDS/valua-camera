import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'indicator.dart';

class AttendancePieChart extends StatelessWidget {
  const AttendancePieChart({
    Key? key,
    required this.attended,
    required this.unattended,
  }) : super(key: key);

  final double attended;
  final double unattended;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: Stack(
                children: [
                  PieChart(
                    PieChartData(
                      borderData: FlBorderData(
                        show: false,
                      ),
                      sectionsSpace: 0,
                      centerSpaceRadius: 60,
                      sections: showingSections([attended, unattended]),
                    ),
                  ),
                  Center(
                    child: Text(
                      (attended + unattended).toStringAsFixed(0),
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
    return [
      PieChartSectionData(
        color: Colors.green[500],
        value: data[0],
        title: data[1] > 0 ? data[0].toStringAsFixed(0) : '',
        radius: radius,
        titleStyle: const TextStyle(
          fontSize: fontSize,
          color: Colors.white,
        ),
      ),
      PieChartSectionData(
        color: Colors.red[500],
        value: data[1],
        title: data[0] > 0 ? data[1].toStringAsFixed(0) : '',
        radius: radius,
        titleStyle: const TextStyle(
          fontSize: fontSize,
          color: Colors.white,
        ),
      )
    ];
  }
}
