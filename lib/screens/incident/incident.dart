import 'package:flutter/material.dart';
import 'package:valua_staff/widgets/round_button.dart';

class IncidentScreen extends StatelessWidget {
  const IncidentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: RoundButton(
          height: 40,
          width: 150,
          color: Colors.blue,
          label: "Submit",
          onPressed: () {},
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Create incident report',
        ),
        leading: const BackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: const [],
          ),
        ),
      ),
    );
  }
}
