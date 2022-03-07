import 'package:flutter/material.dart';
import 'package:valua_camera/widgets/card_button.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _settingModalBottomSheet(context) {
      showModalBottomSheet(
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
                            backgroundColor: Colors.blue[400],
                            child: const Icon(
                              Icons.file_copy_outlined,
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
                            backgroundColor: Colors.blue[600],
                            child: const Icon(
                              Icons.file_copy_outlined,
                              color: Colors.white,
                            ),
                          ),
                          title: const Text('Exam incident report'),
                        )
                      ],
                    )),
              ));
    }

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
          FloatingActionButton(child: const Icon(Icons.add), onPressed: () {}),
    );
  }
}
