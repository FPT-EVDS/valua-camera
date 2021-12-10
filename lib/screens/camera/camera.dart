import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:valua_staff/screens/attendance/attendance.dart';
import 'package:valua_staff/widgets/round_button.dart';

class CameraScreen extends StatefulWidget {
  final List<CameraDescription>? cameras;
  const CameraScreen({this.cameras, Key? key}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController controller;
  XFile? pictureFile;

  @override
  void initState() {
    super.initState();
    controller = CameraController(
      widget.cameras![0],
      ResolutionPreset.max,
    );
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return const SizedBox(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    var size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        elevation: 2,
        backgroundColor: Colors.grey[200],
        onPressed: () async {
          controller.takePicture().then((file) {
            setState(() {
              pictureFile = file;
            });
            if (mounted) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          DisplayPictureScreen(image: pictureFile)));
            }
          });
        },
      ),
      body: Container(
        width: size.width,
        height: size.height,
        child: Stack(
          children: <Widget>[
            Center(
              child: SizedBox(
                height: size.height,
                width: size.width,
                child: CameraPreview(controller),
              ),
            ),
            Container(
              width: size.width,
              height: size.height,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 25, right: 10, left: 10, bottom: 10),
                  child: Stack(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AttendanceScreen()));
                            },
                            child: Text("Attendance",
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.5),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900,
                                )),
                          ),
                          SizedBox(width: 5),
                          Text("|",
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.5),
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                              )),
                          SizedBox(width: 5),
                          Text("Camera",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DisplayPictureScreen extends StatelessWidget {
  final XFile? image;
  DisplayPictureScreen({Key? key, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
          width: size.width,
          height: size.height,
          child: Image.file(
            File(image!.path),
            fit: BoxFit.fill,
          )),
      floatingActionButton: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
              icon: Icon(
                Icons.check,
                size: 60,
                color: Colors.green,
              ),
              onPressed: () {
                showAlertDialog(context);
              }),
          SizedBox(width: 50),
          IconButton(
              icon: Icon(
                Icons.close,
                size: 60,
                color: Colors.red,
              ),
              onPressed: () {
                Navigator.pop(
                  context,
                );
              }),
        ],
      ),
    );
  }
}

showAlertDialog(BuildContext context) {
  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    content: Container(
      width: MediaQuery.of(context).size.width,
      height: 320,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 60,
            backgroundImage: NetworkImage('https://picsum.photos/200?image=66'),
          ),
          SizedBox(height: 30),
          Text("Nguyen Huu Huy - SE140380"),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Attended at: ",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w900)),
              Text("23/08/2021 16:40"),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Seat position: ",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w900)),
              Text("02"),
            ],
          ),
          SizedBox(height: 30),
          RoundButton(
              label: "Confirm",
              width: double.infinity,
              onPressed: () {
                Navigator.pop(
                  context,
                );
              }),
        ],
      ),
    ),
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
