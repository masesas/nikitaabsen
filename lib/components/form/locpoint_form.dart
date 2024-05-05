// import 'package:flutter/material.dart';

// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:form_builder_validators/form_builder_validators.dart';
// import 'package:get/get.dart';
// import 'package:hadir_mobile_v2/components/button/basic_button.dart';
// import 'package:hadir_mobile_v2/controllers/location_point_controller.dart';
// import 'package:hadir_mobile_v2/controllers/request_activity.controller.dart';
// import 'package:hadir_mobile_v2/utils/constants.dart';

// class LocpointForm extends StatefulWidget {
//   const LocpointForm({Key? key}) : super(key: key);

//   @override
//   State<LocpointForm> createState() => _LocpointFormState();
// }

// class _LocpointFormState extends State<LocpointForm> {
//   final locPont = Get.put(LocationFromController());
//   final distance = Get.put(RequestActivityController());
//   final _formKey = GlobalKey<FormBuilderState>();
//   String? _from;
//   String? _to;
//   bool isPasswordVisible = false;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//       margin: MediaQuery.of(context).padding,
//       child: SingleChildScrollView(
//         child: FormBuilder(
//           initialValue: const {
//             'from': null,
//             'to': null,
//           },
//           key: _formKey,
//           child: Column(
//             children: [
//               const SizedBox(
//                 height: 10,
//               ),
//               Obx(() {
//                 return Text(
//                   'Jarak and ${distance.info.value}M, terlalu jauh dari Location Point kantor anda ',
//                   style: const TextStyle(
//                       fontWeight: FontWeight.w700,
//                       fontSize: 17,
//                       color: Colors.black12),
//                 );
//               }),
//               // const Text(
//               //   'Jarak Anda terlalu jauh dari Location Point kantor anda ',
//               //   style: TextStyle(
//               //       fontWeight: FontWeight.w700,
//               //       fontSize: 17,
//               //       color: Colors.black12),
//               // ),
//               const SizedBox(
//                 height: 20,
//               ),
//               FormBuilderTextField(
//                 name: 'notes',
//                 maxLength: 100,
//                 autovalidateMode: AutovalidateMode.onUserInteraction,
//                 validator: FormBuilderValidators.compose([
//                   FormBuilderValidators.required(
//                       errorText: 'Tidak Boleh Kosong !'),
//                 ]),
//                 maxLines: null,
//                 decoration: InputDecoration(
//                   counterText: "",
//                   enabledBorder: UnderlineInputBorder(
//                     borderSide: BorderSide(
//                       color: mainColor,
//                     ),
//                     borderRadius: const BorderRadius.all(
//                       Radius.circular(10),
//                     ),
//                   ),
//                   border: OutlineInputBorder(),
//                   labelText: 'Keterangan',
//                   prefixIcon: Icon(
//                     Icons.note,
//                     color: mainColor,
//                   ),
//                 ),
//                 keyboardType: TextInputType.multiline,
//                 textInputAction: TextInputAction.newline,
//               ),
//               const SizedBox(
//                 height: 25,
//               ),
//               Obx(() => BasicButton(
//                     onPressed: locPont.loading.value ? null : () async {},
//                     basicText: 'Kirim',
//                     color: mainColor,
//                     isLoading: locPont.loading.value,
//                     loadingText: 'Memproses',
//                   ))
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
