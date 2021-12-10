import 'package:evds_examinee/screens/login/login_controller.dart';
import 'package:evds_examinee/widgets/round_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _controller = Get.find<LoginController>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "\u00a9 EVDS for Examinee 2021, All rights reserved",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey.shade500,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Center(
                child: Image.asset(
                  "assets/icons/evds_logo_right.png",
                  fit: BoxFit.cover,
                  height: 200,
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
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: "Email",
                      ),
                      validator: MultiValidator([
                        EmailValidator(errorText: "Invalid email"),
                        RequiredValidator(errorText: "Email is required")
                      ]),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      obscureText: true,
                      controller: _controller.passwordController,
                      decoration: const InputDecoration(
                        labelText: "Password",
                      ),
                      validator:
                          RequiredValidator(errorText: "Password is required"),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Obx(
                      () => RoundButton(
                        onPressed: () {
                          _controller.login();
                        },
                        height: 45,
                        width: double.infinity,
                        label: "Login",
                        isLoading: _controller.isLoading.value,
                      ),
                    )
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
