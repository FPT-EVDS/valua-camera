import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:valua_staff/screens/attendance/attendance_view.dart';
import 'package:valua_staff/screens/dashboard/dashboard.dart';
import 'package:valua_staff/widgets/custom_list_tile.dart';
import 'package:valua_staff/widgets/header_attendance.dart';
import 'package:valua_staff/widgets/round_button.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({Key? key}) : super(key: key);

  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen>
    implements AttendanceView {
  _AttendanceScreenState() {}
  @override
  Widget build(BuildContext context) {
    ChartType? _chartType = ChartType.ring;

    final dataMap = <String, double>{
      "Attended": 4,
      "Unattended": 3,
    };
    final colorList = <Color>[
      const Color.fromRGBO(0, 180, 0, 40),
      const Color.fromRGBO(255, 0, 0, 40),
    ];
    bool _showChartValuesOutside = true;
    bool _showLegendsInRow = true;
    bool _showCenterText = true;
    double? _ringStrokeWidth = 30;
    bool _showChartValueBackground = false;

    LegendPosition? _legendPosition = LegendPosition.bottom;

    void _settingModalBottomSheet(context) {
      showModalBottomSheet(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          context: context,
          builder: (context) => Container(
                height: 200,
                child: new Container(
                    decoration: new BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Text('Authorization required',
                            style: TextStyle(
                                fontWeight: FontWeight.w900, fontSize: 15)),
                        SizedBox(height: 20),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
                          child: TextFormField(
                            obscureText: true,
                            decoration: const InputDecoration(
                              labelText: "Staff password",
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        RoundButton(
                          height: 45,
                          width: 300,
                          color: Colors.blue,
                          label: "Submit",
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DashboardScreen()));
                          },
                        )
                      ],
                    )),
              ));
    }

    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: RoundButton(
          height: 40,
          width: 150,
          color: Colors.blue,
          label: "Finish checking",
          onPressed: () {
            _settingModalBottomSheet(context);
          },
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
                  CustomListTile(
                    attended: true,
                    imageUrl: "https://picsum.photos/200",
                    leadingNumber: 8,
                    subtitle: "Ho Thi Ky",
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
