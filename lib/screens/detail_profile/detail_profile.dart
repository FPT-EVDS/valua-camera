import 'package:dropdown_search/dropdown_search.dart';
import 'package:evds_staff/screens/detail_profile/detail_profile_controller.dart';
import 'package:evds_staff/widgets/cached_circle_avatar.dart';
import 'package:evds_staff/widgets/round_button.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';

class DetailProfileScreen extends StatelessWidget {
  const DetailProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _controller = Get.find<DetailProfileController>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Update profile"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: GestureDetector(
                    onTap: () {},
                    child: CachedCircleAvatar(
                      imageUrl: _controller.currentUser.imageUrl.toString(),
                      radius: 45,
                    ),
                  ),
                ),
                Form(
                  key: _controller.formKey,
                  child: Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: _controller.emailController,
                        readOnly: true,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: "Email",
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Obx(
                        () => DropdownSearch<String>(
                          mode: Mode.MENU,
                          showSelectedItems: true,
                          items: _controller.genders,
                          maxHeight: 120,
                          dropdownSearchDecoration: const InputDecoration(
                            labelText: "Gender",
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 12.0,
                              vertical: 4.0,
                            ),
                          ),
                          onChanged: (gender) {
                            _controller.gender.value = gender;
                          },
                          selectedItem: _controller.gender.value,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _controller.phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          labelText: "Phone number",
                        ),
                        validator: MultiValidator([
                          RequiredValidator(
                              errorText: "Phone number is required"),
                          MinLengthValidator(10, errorText: "Min length is 10"),
                        ]),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _controller.birthdateController,
                        keyboardType: TextInputType.datetime,
                        decoration: const InputDecoration(
                          labelText: "Date of birth",
                        ),
                        readOnly: true,
                        onTap: () {
                          _controller.selectDate(context);
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _controller.addressController,
                        decoration: const InputDecoration(
                          labelText: "Address",
                        ),
                        validator:
                            RequiredValidator(errorText: "Address is required"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(18),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: Obx(
            () => RoundButton(
              isLoading: _controller.isLoading.value,
              onPressed: () async {
                await _controller.updateProfile(context);
              },
              label: "Update",
            ),
          ),
        ),
      ),
    );
  }
}
