import 'dart:io';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:valua_camera/models/attendance.dart';
import 'package:valua_camera/models/modal_bottom_sheet_item.dart';
import 'package:valua_camera/models/report.dart';
import 'package:valua_camera/screens/detail_violation/detail_violation_controller.dart';
import 'package:valua_camera/widgets/cached_circle_avatar.dart';
import 'package:valua_camera/widgets/round_button.dart';

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

class DetailViolationScreen extends StatelessWidget {
  const DetailViolationScreen({Key? key}) : super(key: key);

  Future _showImageSelector(BuildContext context) {
    final _controller = Get.find<DetailViolationController>();
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

  Widget _buildDropdownItem(BuildContext context, Attendance? attendance) {
    if (attendance == null) {
      return Container();
    }
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      leading: CachedCircleAvatar(
        imageUrl: attendance.subjectExaminee.examinee.imageUrl ??
            'https://i.stack.imgur.com/34AD2.jpg',
        radius: 22,
      ),
      title: Text(attendance.subjectExaminee.examinee.fullName),
      subtitle: Text(attendance.subjectExaminee.examinee.companyId),
    );
  }

  Widget _buildPopupItem(
      BuildContext context, Attendance? attendance, bool isSelected) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
      child: ListTile(
        selected: isSelected,
        title: Text(attendance?.subjectExaminee.examinee.fullName ?? ''),
        subtitle: Text(attendance?.subjectExaminee.examinee.companyId ?? ''),
        leading: CachedCircleAvatar(
          imageUrl: attendance?.subjectExaminee.examinee.imageUrl ??
              'https://i.stack.imgur.com/34AD2.jpg',
          radius: 22,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _controller = Get.find<DetailViolationController>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Update violation report',
        ),
      ),
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(
          () => Visibility(
            visible: !_controller.isResolved.value,
            child: RoundButton(
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
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _controller.formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: FutureBuilder(
              future: _controller.fetchReport(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData) {
                  Report report = snapshot.data;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Obx(
                        () => DropdownSearch<Attendance>(
                          mode: Mode.DIALOG,
                          enabled: !_controller.isResolved.value,
                          showClearButton: true,
                          items: _controller.dashboardController
                              .assignedExamRoom.value!.examRooms[0].attendances,
                          dropdownBuilder: _buildDropdownItem,
                          popupItemBuilder: _buildPopupItem,
                          compareFn: (item, selectedItem) =>
                              item?.attendanceId == selectedItem?.attendanceId,
                          dropdownSearchDecoration: const InputDecoration(
                            labelText: "Violator",
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 12.0,
                              vertical: 4.0,
                            ),
                          ),
                          popupSafeArea:
                              const PopupSafeAreaProps(top: true, bottom: true),
                          onChanged: (attendance) {
                            _controller.selectedAttendance.value = attendance;
                          },
                          validator: (v) =>
                              v == null ? "Violator is required" : null,
                          selectedItem: _controller.selectedAttendance.value,
                        ),
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        controller: _controller.descriptionController,
                        enabled: !_controller.isResolved.value,
                        maxLines: 8,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          labelText: "Description",
                        ),
                        validator: MultiValidator([
                          RequiredValidator(
                              errorText: "Description is required")
                        ]),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        maxLines: 6,
                        enabled: !_controller.isResolved.value,
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
                        child: Obx(
                          () => Container(
                            height: 100.0,
                            width: 100.0,
                            decoration: BoxDecoration(
                              color: Colors.grey[350],
                              border: Border.all(
                                color: _controller.imageError.value.isNotEmpty
                                    ? Colors.red
                                    : Colors.transparent,
                              ),
                            ),
                            child: _controller.image.value != null
                                ? Image.file(
                                    File(_controller.image.value!.path
                                        .toString()),
                                    fit: BoxFit.cover,
                                  )
                                : report.imageUrl != null
                                    ? Image.network(
                                        report.imageUrl.toString(),
                                        fit: BoxFit.cover,
                                      )
                                    : Icon(
                                        CommunityMaterialIcons.image_plus,
                                        color: Colors.grey[600],
                                      ),
                          ),
                        ),
                        onTap: () {
                          if (!_controller.isResolved.value) {
                            _showImageSelector(context);
                          }
                        },
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Obx(
                        () => Text(
                          _controller.imageError.value,
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
