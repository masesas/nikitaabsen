import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:get/get.dart';
import 'package:nikitaabsen/components/button/basic_button.dart';
import 'package:nikitaabsen/controllers/auth.controller.dart';
import 'package:nikitaabsen/models/request/login_request.dart';
import 'package:nikitaabsen/screens/home.dart';
import 'package:nikitaabsen/screens/register.dart';
import 'package:nikitaabsen/utils/constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _authController = Get.put(AuthController());

    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        margin: MediaQuery.of(context).padding,
        child: SingleChildScrollView(
          child: Column(
            children: [
              FormBuilder(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: Image.asset(
                        'assets/images/collection.png',
                        fit: BoxFit.contain,
                        height: 150,
                        width: 400,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FormBuilderTextField(
                      name: 'phone',
                      maxLength: 70,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator:  (value) {
                        if (value == null  ) {
                          return 'Phone tidak boleh kosong  ';
                        }
                        return null;
                      } ,
                      decoration: InputDecoration(
                        counterText: "",
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: mainColor,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        border: OutlineInputBorder(),
                        labelText: 'Phone',
                        prefixIcon: Icon(
                          Icons.phone,
                          color: mainColor,
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    FormBuilderTextField(
                      obscureText: !isPasswordVisible,
                      name: 'password',
                      maxLength: 50,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator:  (value) {
                        if (value == null  ) {
                          return 'Password tidak boleh kosong ';
                        }
                        return null;
                      } ,
                      decoration: InputDecoration(
                        counterText: "",
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: mainColor,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        border: const OutlineInputBorder(),
                        labelText: 'Password',
                        prefixIcon: Icon(
                          Icons.lock,
                          color: mainColor,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () => setState(() {
                            isPasswordVisible = !isPasswordVisible;
                          }),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Obx(
                () => BasicButton(
                  color: mainColor,
                  onPressed: _authController.loading.value
                      ? null
                      : () async {
                          if (_formKey.currentState?.saveAndValidate() ??
                              false) {
                            debugPrint(_formKey.currentState?.value.toString());
                            var formData = _formKey.currentState?.value;
                            var loginData = LoginRequest(
                              email: formData?['phone'],
                              password: formData?['password'],
                              strategy: 'local',
                            );
                            await _authController.handleLogin(loginData);
                          } else {
                            debugPrint(_formKey.currentState?.value.toString());
                            debugPrint('validation failed');
                          }
                        },
                  basicText: 'Masuk',
                  isLoading: _authController.loading.value,
                  loadingText: 'Memproses',
                ),
              ),
              SizedBox(
                height: 25,
              ),
              _buildRedirectToRegister(
                press: () {
                  Get.to(RegisterScreen());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRedirectToRegister({required VoidCallback press}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Belum punya akun? Daftar ",
          style: TextStyle(color: Colors.black),
        ),
        GestureDetector(
          onTap: press,
          child: Text(
            "disini",
            style: TextStyle(
              decoration: TextDecoration.underline,
              color: mainColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
