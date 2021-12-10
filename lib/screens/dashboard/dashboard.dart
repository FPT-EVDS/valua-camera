import 'package:valua_staff/routes/app_pages.dart';
import 'package:valua_staff/screens/camera/camera.dart';
import 'package:valua_staff/screens/report/incident.dart';
import 'package:valua_staff/widgets/card_button.dart';
import 'package:valua_staff/widgets/round_button.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = PageController();

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
                        Text('Choose type of report',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 15)),
                        SizedBox(height: 20),
                        ListTile(
                          onTap: () {},
                          leading: CircleAvatar(
                            radius: 22,
                            backgroundColor: Colors.blue[400],
                            child: Icon(
                              Icons.file_copy_outlined,
                              color: Colors.white,
                            ),
                          ),
                          title: Text('Exam regulation report'),
                        ),
                        SizedBox(height: 10),
                        ListTile(
                          onTap: () {},
                          leading: CircleAvatar(
                            radius: 22,
                            backgroundColor: Colors.blue[600],
                            child: Icon(
                              Icons.file_copy_outlined,
                              color: Colors.white,
                            ),
                          ),
                          title: Text('Exam incident report'),
                        )
                      ],
                    )),
              ));
    }

    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
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
                icon: Icons.school,
                onPressed: () {},
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
                icon: Icons.article,
                onPressed: () {
                  _settingModalBottomSheet(context);
                },
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
              CardButton(
                icon: Icons.camera_alt,
                onPressed: () {},
                width: double.infinity,
                label: 'Camera',
                detail: 'View image gallery',
                height: 80,
                color: Colors.white,
                labelColor: Colors.blue,
              ),
              const SizedBox(
                height: 20,
              ),

              // room
            ],
          ),
        ),
      ),
      floatingActionButton:
          FloatingActionButton(child: Icon(Icons.add), onPressed: () {}),
    );
  }
}
