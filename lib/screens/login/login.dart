import 'package:evds_staff/routes/app_pages.dart';
import 'package:evds_staff/widgets/round_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "\u00a9 EVDS for Staff 2021, All rights reserved",
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
              Column(
                children: <Widget>[
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    autofocus: true,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: "Email",
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    autofocus: true,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: "Password",
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  RoundButton(
                    onPressed: () {
                      // FIXME: call api instead of hardcode
                      Get.offAllNamed(AppRoutes.main);
                    },
                    height: 45,
                    width: double.infinity,
                    label: "Login",
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
