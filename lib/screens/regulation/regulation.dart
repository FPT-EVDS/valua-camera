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

    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: RoundButton(
          height: 40,
          width: 150,
          color: Colors.blue,
          label: "Submit",
          onPressed: () {
            _controller.submit();
          },
        ),
      ),
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
                SizedBox(
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
                        // const SizedBox(
                        //   width: 40,
                        // ),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
