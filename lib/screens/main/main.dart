import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:valua_camera/models/exam_room.dart';
import 'package:valua_camera/screens/camera/camera.dart';
import 'package:valua_camera/widgets/round_button.dart';

late List<CameraDescription> cameras = [];
ExamRoom? _assignedExamRoom;

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  // Future<void> main() async {
  //   try {
  //     WidgetsFlutterBinding.ensureInitialized();
  //     cameras = await availableCameras();
  //   } on CameraException catch (e) {
  //     print('Error in fetching the cameras: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // final controller = PageController();
    // var dateTime = DateTime.parse(_assignedExamRoom!.createdDate);
    return Scaffold(
      body: SafeArea(
        bottom: true,
        top: true,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Text(
                _assignedExamRoom != null
                    ? _assignedExamRoom!.examRoomName
                    : 'FA Spring 2022',
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Image.asset(
                    "assets/icons/classroom.png",
                    fit: BoxFit.cover,
                    height: 130,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // date
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Date: ',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    _assignedExamRoom != null
                        ? _assignedExamRoom!.createdDate
                        : 'date',
                    style: const TextStyle(
                      fontWeight: FontWeight.w200,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              // time
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Time: ',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    '14:15 - 15:45',
                    style: TextStyle(
                      fontWeight: FontWeight.w200,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              // room
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Room: ',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    '201',
                    style: TextStyle(
                      fontWeight: FontWeight.w200,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              // subject
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Subject: ',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    'SSG001',
                    style: TextStyle(
                      fontWeight: FontWeight.w200,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              // total examinees
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Total examinees: ',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    '20',
                    style: TextStyle(
                      fontWeight: FontWeight.w200,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: RoundButton(
        height: 45,
        width: 300,
        color: Colors.blue,
        label: "Start attendance checking",
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
