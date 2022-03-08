// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:valua_camera/routes/routes.dart';
import 'package:valua_camera/screens/dashboard/dashboard.dart';
import 'package:valua_camera/screens/regulation/regulation_controller.dart';
import 'package:valua_camera/widgets/round_button.dart';
import 'package:valua_camera/widgets/violator_list_title.dart';

class RegulationScreen extends StatelessWidget {
  RegulationScreen({Key? key}) : super(key: key);
  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final _controller = Get.find<RegulationController>();
    var data = Get.arguments;
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
                          elevation: 0,
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
                    child: Obx(
                      () => (_controller.chooseImage.value != null)
                          ? (Image.file(File(_controller.chooseImage.value!),
                              fit: BoxFit.fill))
                          : Icon(CommunityMaterialIcons.image_plus,
                              color: Colors.grey[600]),
                    ),
                  ),
                  onTap: () {
                    _controller.handleChangeImage();
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
