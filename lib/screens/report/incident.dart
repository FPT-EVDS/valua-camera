import 'package:valua_staff/routes/app_pages.dart';
import 'package:valua_staff/screens/camera/camera.dart';
import 'package:valua_staff/widgets/card_button.dart';
import 'package:valua_staff/widgets/round_button.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class IncidentScreen extends StatelessWidget {
  const IncidentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Create incident report',
        ),
        leading: BackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}
