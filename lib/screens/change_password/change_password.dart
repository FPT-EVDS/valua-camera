import 'package:community_material_icon/community_material_icon.dart';
import 'package:evds_examinee/screens/change_password/change_password_controller.dart';
import 'package:evds_examinee/widgets/round_button.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _controller = Get.find<ChangePasswordController>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Change password"),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: GestureDetector(
                  onTap: () {},
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                    child: const Icon(
                      CommunityMaterialIcons.lock_reset,
                      size: 35,
                    ),
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
                      controller: _controller.currentPasswordController,
                      decoration: const InputDecoration(
                        labelText: "Current password",
                      ),
                      obscureText: true,
                      validator: RequiredValidator(
                          errorText: "Current password is required"),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _controller.newPasswordController,
                      decoration: const InputDecoration(
                        labelText: "New password",
                      ),
                      validator: RequiredValidator(
                          errorText: "New password is required"),
                      obscureText: true,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _controller.confirmPasswordController,
                      decoration: const InputDecoration(
                        labelText: "Confirm new password",
                      ),
                      validator: (value) => MatchValidator(
                              errorText: "Confirm password do not match")
                          .validateMatch(
                        value.toString(),
                        _controller.newPasswordController.text,
                      ),
                      obscureText: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(18),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: RoundButton(
            onPressed: () {
              _controller.updatePassword(context);
            },
            label: "Update",
          ),
        ),
      ),
    );
  }
}
