import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:valua_staff/models/exam_room.dart';
import 'package:valua_staff/screens/camera/camera.dart';
import 'package:valua_staff/screens/main/main_presenter.dart';
import 'package:valua_staff/screens/main/main_view.dart';
import 'package:valua_staff/widgets/round_button.dart';

late List<CameraDescription> cameras = [];

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> implements MainView {
  late MainPresenter _presenter;
  bool _showEmpty = false;
  bool _isLoading = true;
  ExamRoom? _assignedExamRoom;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  _MainScreenState() {
    _presenter = MainPresenter(this);
    _presenter.loadExamRoom();
  }

  @override
  void loadExamRoom(examRoom) {
    setState(() {
      _isLoading = false;
      _showEmpty = false;
      this._assignedExamRoom = examRoom;
    });
  }

  @override
  void refesh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _presenter.loadExamRoom();
    _refreshController.refreshCompleted();
  }

  @override
  void showEmptyExamRoom() {
    setState(() {
      _isLoading = false;
      _showEmpty = true;
    });
    _refreshController.refreshCompleted();
  }

  Future<void> main() async {
    try {
      WidgetsFlutterBinding.ensureInitialized();
      cameras = await availableCameras();
    } on CameraException catch (e) {
      print('Error in fetching the cameras: $e');
    }
  }

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
                style: TextStyle(
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
                  Text(
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
              // time
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                children: [
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
                children: [
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
                children: [
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
