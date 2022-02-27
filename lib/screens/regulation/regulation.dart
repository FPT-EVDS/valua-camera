// ignore_for_file: override_on_non_overriding_member, unused_field, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:valua_camera/routes/routes.dart';
import 'package:valua_camera/screens/dashboard/dashboard.dart';
import 'package:valua_camera/screens/regulation/regulation_controller.dart';
import 'package:valua_camera/widgets/round_button.dart';
import 'package:valua_camera/widgets/violator_list_title.dart';

class RegulationScreen extends StatefulWidget {
  const RegulationScreen({Key? key}) : super(key: key);

  @override
  _RegulationScreenState createState() => _RegulationScreenState();
}

class _RegulationScreenState extends State<RegulationScreen> {
  File? _image;
  final _picker = ImagePicker();
  final _form = GlobalKey<FormState>();

  void pickImage() async {
    final image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(image!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    final _controller = Get.find<RegulationController>();
    var data = Get.arguments;
    // print(data);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Create regulation report',
        ),
        leading: IconButton(
          icon: const Icon(CommunityMaterialIcons.chevron_left),
          onPressed: () {
            Get.off(DashboardScreen());
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Violator', textAlign: TextAlign.start),
                const SizedBox(
                  height: 5,
                ),
                Get.arguments != null
                    ? InkWell(
                        child: Card(
                          elevation: 1,
                          margin: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 0.0,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: ViolatorListTile(
                              title: data['id'].toString(),
                              subtitle: data['fullName'].toString(),
                              imageUrl: data['imageUrl'].toString(),
                              position: data['pos'].toString(),
                            ),
                          ),
                        ),
                        onTap: () {
                          Get.offAndToNamed(AppRoutes.violator);
                        },
                      )
                    : SizedBox(
                        width: 400,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            Get.offAndToNamed(AppRoutes.violator);
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0.0,
                            primary: Colors.red.withOpacity(0),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.blue),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "                    Select violator              ",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                ),
                              ),
                              Icon(
                                CommunityMaterialIcons.plus,
                                color: Colors.blue,
                              ),
                            ],
                          ),
                        ),
                      ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  key: _form,
                  controller: _controller.descriptionController,
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
                  () => RoundButton(
                    onPressed: () {
                      _controller.submitReport(
                        data['imageUrl'].toString(),
                        data['violatorId'].toString(),
                        data['examRoomId'].toString(),
                      );
                    },
                    height: 45,
                    width: double.infinity,
                    label: "Submit",
                    isLoading: _controller.isLoading.value,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
