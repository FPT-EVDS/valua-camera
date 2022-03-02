// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:valua_camera/models/exam_room.dart';
import 'package:valua_camera/screens/incident/incident_controller.dart';
import 'package:valua_camera/widgets/round_button.dart';

class IncidentScreen extends StatefulWidget {
  const IncidentScreen({Key? key}) : super(key: key);

  @override
  _IncidentScreenState createState() => _IncidentScreenState();
}

class _IncidentScreenState extends State<IncidentScreen> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  final _form = GlobalKey<FormState>();

  //for storing form state.

  void pickImage() async {
    final image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(image!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    final _controller = Get.find<IncidentController>();
    return Scaffold(
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
            children: [
              Form(
                key: _controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _controller.descriptionController,
                      key: _form,
                      maxLines: 8,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Description",
                      ),
                      validator: MultiValidator([
                        RequiredValidator(errorText: "Description is required")
                      ]),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      maxLines: 6,
                      controller: _controller.noteController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Note",
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text('Images', textAlign: TextAlign.start),
                    const SizedBox(
                      height: 5,
                    ),
                    InkWell(
                      child: Container(
                        height: 100.0,
                        width: 100.0,
                        color: Colors.grey[350],
                        child: _image != null
                            ? Image.file(_image!, fit: BoxFit.fill)
                            : Icon(CommunityMaterialIcons.image_plus,
                                color: Colors.grey[600]),
                      ),
                      onTap: () {
                        pickImage();
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Obx(
                      () => FutureBuilder(
                        future: _controller.assignedExamRoom.value,
                        builder: (BuildContext context,
                            AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.hasData) {
                            ExamRoom data = snapshot.data;
                            // print("Huy pro");
                            // print(data.examRoomName);
                            // print(data.examRoomId);
                            // print(snapshot.hasData);
                            return Obx(
                              () => RoundButton(
                                onPressed: () {
                                  _controller.submitReport(
                                    "imageUrl",
                                    data.examRoomId,
                                  );
                                },
                                height: 45,
                                width: double.infinity,
                                label: "Submit",
                                isLoading: _controller.isLoading.value,
                              ),
                            );
                          }
                          return Obx(
                            () => RoundButton(
                              onPressed: () {},
                              height: 45,
                              width: double.infinity,
                              label: "Null",
                              isLoading: _controller.isLoading.value,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
