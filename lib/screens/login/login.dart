import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:valua_camera/models/generated_qr.dart';
import 'package:valua_camera/screens/login/login_controller.dart';
import 'package:valua_camera/widgets/round_button.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final _controller = Get.find<LoginController>();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(200),
          child: AppBar(
            centerTitle: true,
            flexibleSpace: ClipRRect(
              borderRadius: const BorderRadius.only(),
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/icons/valua.png"),
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ),
            bottom: const TabBar(
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              labelStyle: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
              tabs: [Tab(text: ("Login with QR")), Tab(text: ("Login"))],
            ),
          ),
        ),
        resizeToAvoidBottomInset: true,
        bottomNavigationBar: BottomAppBar(
          elevation: 0,
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "\u00a9 Valua Camera 2022, All rights reserved",
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
            child: TabBarView(
              children: [
                // QR Login
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Obx(
                      () => FutureBuilder(
                          future: _controller.qrData.value,
                          builder: (BuildContext context,
                              AsyncSnapshot<dynamic> snapshot) {
                            if (snapshot.hasData) {
                              GeneratedQR data = snapshot.data;
                              return QrImage(
                                data: data.data.token,
                                version: QrVersions.auto,
                                padding: const EdgeInsets.all(8.0),
                                size: MediaQuery.of(context).size.height / 2.3,
                              );
                            } else if (snapshot.hasError) {
                              return Center(
                                child: Text(
                                  snapshot.error.toString(),
                                ),
                              );
                            }
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Scan QR Code with staff app. ",
                          style: TextStyle(fontSize: 16),
                        ),
                        GestureDetector(
                          onTap: () {
                            _controller.refreshQR();
                          },
                          child: const Text(
                            "Refresh QR",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.blue,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                // Email Login
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Form(
                        key: formKey,
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
                                RequiredValidator(
                                    errorText: "Email is required")
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
                              validator: RequiredValidator(
                                  errorText: "Password is required"),
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            Obx(
                              () => RoundButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    _controller.login();
                                  }
                                },
                                height: 45,
                                width: double.infinity,
                                label: "Login",
                                isLoading: _controller.isLoading.value,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            RoundButton(
                              onPressed: () {
                                _controller.loginWithGoogle();
                              },
                              height: 45,
                              icon: const Icon(CommunityMaterialIcons.google),
                              width: double.infinity,
                              label: "Login with Google",
                              color: Colors.red,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
