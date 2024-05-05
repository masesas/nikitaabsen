import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:nikitaabsen/components/button/basic_button.dart';
import 'package:nikitaabsen/components/camera/cameras.dart';
import 'package:nikitaabsen/controllers/auth.controller.dart';
import 'package:nikitaabsen/models/response/upload_response.model.dart';
import 'package:nikitaabsen/services/upload.service.dart';
import 'package:nikitaabsen/utils/app_utils.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/constants.dart';
import 'login.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key, this.imagePath}) : super(key: key);
  final XFile? imagePath;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _authController = Get.put(AuthController());

  final _formKey = GlobalKey<FormBuilderState>();
  bool isPasswordVisible = false;
  final nameRegExp =
      new RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$");

  PickedFile? _image;
  final ImagePicker _picker = ImagePicker();
  XFile? imagePath;

  var error = false.obs;
  var message = ''.obs;
  setErrorAndMessage(bool value, String errorMsg) {
    error.value = value;
    message.value = errorMsg;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        margin: MediaQuery.of(context).padding,
        child: SingleChildScrollView(
          child: Column(
            children: [
              FormBuilder(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: Image.asset(
                        'assets/images/collection.png',
                        fit: BoxFit.contain,
                        height: 150,
                        width: 150,
                      ),
                    ),
                    imageProfile(),
                    const SizedBox(
                      height: 20,
                    ),
                    FormBuilderTextField(
                      name: 'fullname',
                      maxLength: 70,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null  ) {
                          return 'Nama tidak boleh kosong ';
                        }
                        return null;
                      } ,

                     /* FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText: 'Nama tidak boleh kosong'),
                        FormBuilderValidators.match(r'^[a-z A-Z]+$',
                            errorText: 'Nama tidak valid!'),
                      ]),*/
                      decoration: InputDecoration(
                        counterText: '',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: mainColor,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        border: const OutlineInputBorder(),
                        labelText: 'Nama Lengkap',
                        prefixIcon: Icon(
                          Icons.person,
                          color: mainColor,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    FormBuilderTextField(
                      name: 'phone',
                      maxLength: 70,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null  ) {
                          return 'Phone tidak boleh kosong';
                        }
                        return null;
                      } ,
                      decoration: InputDecoration(
                        counterText: '',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: mainColor,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        border: const OutlineInputBorder(),
                        labelText: 'Phone',
                        prefixIcon: Icon(
                          Icons.phone,
                          color: mainColor,
                        ),
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    FormBuilderTextField(
                      obscureText: !isPasswordVisible,
                      name: 'password',
                      maxLength: 50,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null  ) {
                          return 'Password tidak boleh kosong';
                        }
                        return null;
                      } ,

                      /*FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText: 'Password tidak boleh kosong'),
                        FormBuilderValidators.minLength(8,
                            errorText: 'Password minimal 8 karakter'),
                        FormBuilderValidators.match(passwordRegex,
                            errorText:
                                'Password harus kombinasi angka dan huruf'),
                      ]),*/
                      decoration: InputDecoration(
                        counterText: '',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: mainColor,
                          ),
                          borderRadius: const BorderRadius.all(
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
                    const SizedBox(
                      height: 20,
                    ),
                    FormBuilderTextField(
                      name: 'company_code',
                      maxLength: 8,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null  ) {
                          return 'Kode perusahaan tidak boleh kosong';
                        }
                        return null;
                      } ,
                      decoration: InputDecoration(
                        counterText: '',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: mainColor,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        border: const OutlineInputBorder(),
                        labelText: 'Kode Perusahaan',
                        prefixIcon: Icon(
                          Icons.work,
                          color: mainColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              BasicButton(
                  onPressed: () async {
                    if (_formKey.currentState?.saveAndValidate() ?? false) {
                      if (imagePath != null) {
                        debugPrint(_formKey.currentState?.value.toString());
                        EasyLoading.show();

                        var response = await _authController.register(
                            _formKey.currentState!.value['fullname'].toString(),
                            _formKey.currentState!.value['email'].toString(),
                            _formKey.currentState!.value['password'].toString(),
                            _formKey.currentState!.value['company_code']
                                .toString(),
                            imagePath!);

                        //  debugPrint(response);
                        //   Get.to(const LoginScreen());
                      } else {
                        EasyLoading.showError('Foto wajib diupload!');
                      }
                    } else {
                      debugPrint(_formKey.currentState?.value.toString());
                      debugPrint('validation failed');
                    }
                  },
                  basicText: 'Daftar',
                  isLoading: _authController.loading.value,
                  loadingText: 'Memproses',
                  color: mainColor),
            ],
          ),
        ),
      ),
    );
  }

  Widget imageProfile() {
    return Center(
      child: Stack(children: <Widget>[
        CircleAvatar(
            radius: 80.0,
            backgroundImage: imagePath == null
                ? const AssetImage("assets/images/default_profile.jpg")
                : FileImage(File(imagePath!.path)) as ImageProvider),
        Positioned(
          bottom: 20.0,
          right: 5.0,
          child: InkWell(
            //takePhoto(ImageSource.camera)
            onTap: () async {
              XFile? imageFromCamera = await Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Cameras()));
              if (imageFromCamera != null) {
                setState(() {
                  imagePath = imageFromCamera;
                });
              }
            },
            child: const Icon(
              Icons.camera_alt,
              color: Colors.teal,
              size: 28.0,
            ),
          ),
        ),
      ]),
    );
  }
}
