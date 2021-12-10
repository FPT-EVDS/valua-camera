import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:valua_staff/screens/camera/camera.dart';

late List<CameraDescription> cameras = [];

class HeaderAttendance extends StatelessWidget {
  Future<void> main() async {
    try {
      WidgetsFlutterBinding.ensureInitialized();
      cameras = await availableCameras();
    } on CameraException catch (e) {
      print('Error in fetching the cameras: $e');
    }
  }

  const HeaderAttendance({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          child: Text(
            "Attendance",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
          onPressed: () {},
        ),
        Text(
          '|',
          style: TextStyle(color: Colors.black),
        ),
        TextButton(
          child: Text(
            "Camera",
            style: TextStyle(
                color: Colors.grey, fontSize: 18, fontWeight: FontWeight.w100),
          ),
          onPressed: () async {
            await availableCameras().then(
              (value) => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CameraScreen(
                    cameras: value,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
