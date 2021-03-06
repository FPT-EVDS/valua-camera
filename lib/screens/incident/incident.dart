import 'dart:io';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:valua_camera/models/modal_bottom_sheet_item.dart';
import 'package:valua_camera/screens/incident/incident_controller.dart';
import 'package:valua_camera/widgets/round_button.dart';
import 'package:valua_camera/widgets/text_field_validator.dart';

final pickImageTypes = [
  ModalBottomSheetItem(
    color: const Color(0xFF1890FF),
    iconData: CommunityMaterialIcons.image_plus,
    onTap: () {},
    title: 'Gallery',
  ),
  ModalBottomSheetItem(
    color: const Color(0xFF1890FF),
    iconData: CommunityMaterialIcons.camera_plus,
    onTap: () {},
    title: 'Camera',
  ),
];

class IncidentScreen extends StatelessWidget {
  const IncidentScreen({Key? key}) : super(key: key);

  Future _showImageSelector(BuildContext context) {
    final _controller = Get.find<IncidentController>();
    return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      context: context,
      builder: (context) => SizedBox(
        height: 190,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Select image source',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 30),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: pickImageTypes
                    .map(
                      (type) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Column(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                // Close modal bottom sheet
                                Get.back();
                                _controller.pickImage(
                                  pickImageTypes.indexOf(type),
                                );
                              },
                              child: Icon(type.iconData),
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                  const CircleBorder(),
                                ),
                                padding: MaterialStateProperty.all(
                                  const EdgeInsets.all(20),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(type.title),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              )
            ],
          ),
        ),
      ),
    );
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
      ),
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(
          () => RoundButton(
            isLoading: _controller.isLoading.value,
            onPressed: () {
              _controller.submitReport();
            },
            width: double.infinity,
            height: 48,
            label: 'Submit',
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _controller.formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _controller.descriptionController,
                  maxLines: 8,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: "Description",
                  ),
                  validator: MultiValidator([
                    RequiredValidator(errorText: "Description is required"),
                    NoWhiteSpaceStringValidator(
                      errorText: "Description is required",
                    ),
                  ]),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  maxLines: 6,
                  controller: _controller.noteController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: "Note",
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text('Image', textAlign: TextAlign.start),
                const SizedBox(
                  height: 5,
                ),
                InkWell(
                  child: Container(
                    height: 100.0,
                    width: 100.0,
                    color: Colors.grey[350],
                    child: Obx(
                      () => _controller.image.value != null
                          ? Image.file(
                              File(_controller.image.value!.path.toString()),
                              fit: BoxFit.cover,
                            )
                          : Icon(
                              CommunityMaterialIcons.image_plus,
                              color: Colors.grey[600],
                            ),
                    ),
                  ),
                  onTap: () {
                    _showImageSelector(context);
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
