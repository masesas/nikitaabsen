import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:facesdk_plugin/facesdk_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:nikitaabsen/components/button/basic_button.dart';
import 'package:nikitaabsen/components/camera/cameras.dart';
import 'package:nikitaabsen/controllers/auth.controller.dart';
import 'package:nikitaabsen/models/response/upload_response.model.dart';
import 'package:nikitaabsen/person.dart';
import 'package:nikitaabsen/services/upload.service.dart';
import 'package:nikitaabsen/utils/app_utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
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
                        if (value == null) {
                          return 'Nama tidak boleh kosong ';
                        }
                        return null;
                      },

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
                        if (value == null) {
                          return 'Phone tidak boleh kosong';
                        }
                        return null;
                      },
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
                        if (value == null) {
                          return 'Password tidak boleh kosong';
                        }
                        return null;
                      },

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
                    Visibility(
                      visible: false,
                      child: FormBuilderTextField(
                        name: 'company_code',
                        maxLength: 8,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null) {
                            return 'Kode perusahaan tidak boleh kosong';
                          }
                          return null;
                        },
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
                            _formKey.currentState!.value['phone'].toString(),
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
              enrollPerson();

            /*  XFile? imageFromCamera = await Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Cameras()));

              if (imageFromCamera != null) {
                setState(() {
                  imagePath = imageFromCamera;
                });
              }*/
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


  Future<Database> createDB() async {
    final database = openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(await getDatabasesPath(), 'person.db'),
      // When the database is first created, create a table to store dogs.
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        return db.execute(
          'CREATE TABLE person(name text, faceJpg blob, templates blob)',
        );
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );

    return database;
  }

  // A method that retrieves all the dogs from the dogs table.
  Future<List<Person>> loadAllPersons() async {
    // Get a reference to the database.
    final db = await createDB();

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('person');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return Person.fromMap(maps[i]);
    });
  }

  Future<void> insertPerson(Person person) async {
    // Get a reference to the database.
    final db = await createDB();

    // Insert the Dog into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      'person',
      person.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    setState(() {
      //widget.personList.add(person);
    });
  }

  Future<void> deleteAllPerson() async {
    final db = await createDB();
    await db.delete('person');

    setState(() {
      //widget.personList.clear();
    });

    Fluttertoast.showToast(
        msg: "All person deleted!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
  Future enrollPerson() async {
    final _facesdkPlugin = FacesdkPlugin();
    try {

      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      var rotatedImage =
      await FlutterExifRotation.rotateImage(path: image.path);

       await deleteAllPerson();

      final faces = await _facesdkPlugin.extractFaces(rotatedImage.path);
      for (var face in faces) {
        num randomNumber =
            10000 + Random().nextInt(10000); // from 0 upto 99 included
        Person person = Person(
            name: 'Person' + randomNumber.toString(),
            faceJpg: face['faceJpg'],
            templates: face['templates']);
        insertPerson(person);
      }

      if (faces.length == 0) {
        Fluttertoast.showToast(
            msg: "No face detected!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: "Person enrolled!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } catch (e) {}
  }
}
