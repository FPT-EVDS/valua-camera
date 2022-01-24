import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:valua_staff/routes/app_pages.dart';
import 'package:valua_staff/screens/login/login_controller.dart';
import 'package:valua_staff/screens/login/login_view.dart';
import 'package:valua_staff/screens/main/main_screen.dart';
import 'package:valua_staff/widgets/round_button.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> implements LoginView {
  final _formKey = GlobalKey<FormState>();
  late LoginPresenter _presenter;
  String _errorMessage = "";
  bool _isLoading = false;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  _LoginScreenState() {
    _presenter = LoginPresenter(this);
  }
  @override
  void loginFail(errorMessage) {
    Fluttertoast.showToast(msg: "Email or password is incorrect");
    setState(() {
      _isLoading = false;
      _errorMessage = errorMessage;
    });
  }

  @override
  void loginSuccess(user) {
    Fluttertoast.showToast(msg: "Login successful");
    setState(() {
      _isLoading = false;
    });
    Navigator.pushNamedAndRemoveUntil(
        context, AppRoutes.main, (route) => false);
  }

  void submitForm() {
    String email = _emailController.text;
    String password = _passwordController.text;
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      print("dô dô");
      _presenter.login(email, password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(200),
          child: AppBar(
            centerTitle: true,
            flexibleSpace: ClipRRect(
              borderRadius: BorderRadius.only(),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/icons/valua.png"),
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ),
            bottom: TabBar(
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
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: BottomAppBar(
          elevation: 0,
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "\u00a9 VALUA for Examinee 2021, All rights reserved",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey.shade500,
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            Center(
              child: Image(
                image: AssetImage("assets/icons/qr.png"),
              ),
            ),
            Center(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            const SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              controller: _emailController,
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
                              controller: _passwordController,
                              decoration: const InputDecoration(
                                labelText: "Password",
                              ),
                              validator: RequiredValidator(
                                  errorText: "Password is required"),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            RoundButton(
                              onPressed: () {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => MainScreen()));
                                submitForm();
                              },
                              height: 45,
                              width: double.infinity,
                              label: "Login",
                              isLoading: _isLoading,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            RoundButton(
                              onPressed: () {},
                              height: 45,
                              width: double.infinity,
                              label: "Log in with Google",
                              isLoading: _isLoading,
                              color: Colors.red,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
