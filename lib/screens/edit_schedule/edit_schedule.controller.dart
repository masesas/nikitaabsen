import 'package:awesome_select/awesome_select.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:nikitaabsen/models/schedule.dart';
import 'package:nikitaabsen/models/workday.dart';

import '../../models/user.model.dart';
import '../../services/schedule.service.dart';
import '../../services/shifting.service.dart';
import '../../utils/app_utils.dart';
import '../../utils/constants.dart';

class EditScheduleController extends GetxController {
  final formKey = GlobalKey<FormBuilderState>();

  List<S2Choice<String>> typeOptions = [
    S2Choice<String>(value: '1', title: 'Tetap'),
    S2Choice<String>(value: '3', title: 'Flexibel'),
  ];

  var loading = false.obs;
  var valueSenin = ''.obs;
  var valueSelasa = ''.obs;
  var valueRabu = ''.obs;
  var valueKamis = ''.obs;
  var valueJumat = ''.obs;
  var valueSabtu = ''.obs;
  var valueMinggu = ''.obs;
  var selectedTipe = ''.obs;
  String? defaultSelectedType = '';
  var dumlist = [];

  var options = <S2Choice<String>>[].obs;
  var userUp = <User>[].obs;
  var selectedWorkday = {}.obs;

  EditScheduleController();

  @override
  void onInit() {
    super.onInit();
    getShiftingList();
    initialize();
  }

  void initialize() {}

  void setLoading(bool value) {
    loading.value = value;
  }

  void initSelectedWorkday() {
    selectedWorkday.addAll({
      '1': options[0].value,
      '2': options[0].value,
      '3': options[0].value,
      '4': options[0].value,
      '5': options[0].value,
      '6': options[0].value,
      '7': options[0].value,
    });
  }

  Future<void> getShiftingList() async {
    setLoading(true);
    final shifting = await ShiftingService().find({});
    //print(jsonEncode(shifting));
    options.value = shifting.data!.map((element) {
      return S2Choice<String>(value: element.id!, title: element.name);
    }).toList();

    options.add(S2Choice<String>(value: '2', title: 'Libur'));

    final args = Get.arguments as Schedule;
    selectedTipe.value = args.type!;

    selectedWorkday.addAll({
      '1': defaultSelected(args.workday, '1'),
      '2': defaultSelected(args.workday, '2'),
      '3': defaultSelected(args.workday, '3'),
      '4': defaultSelected(args.workday, '4'),
      '5': defaultSelected(args.workday, '5'),
      '6': defaultSelected(args.workday, '6'),
      '7': defaultSelected(args.workday, '7'),
    });

    options.refresh();

    setLoading(false);
  }

  List mappingWorkdayList() {
    List workdayList = [];

    selectedWorkday.forEach((key, value) {
      workdayList.add(
        {
          'name': AppUtils.mapDays(key),
          'day': key,
          'shifting_id': value == "2" ? null : value,
        },
      );
    });

    return workdayList;
  }

  void handleSubmitWorkday() {
    print(selectedWorkday);
    Get.back(result: selectedWorkday);
  }

  void handleSubmitSchedule(String id) async {
    if (formKey.currentState?.saveAndValidate() ?? false) {
      EasyLoading.show();

      var user = AppUtils.getUser();
      var formData = formKey.currentState?.value;

      try {
        Map<String, dynamic> body = {
          'name': formData?['nama_jadwal'],
          'type': selectedTipe.value,
          'effective_date': formData?['effective_date'].toString(),
          'company_id': user.companyId,
          'workday': mappingWorkdayList()
        };

        // EasyLoading.dismiss();

        // print(body);
        // return;

        await ScheduleService().patch(id, body);

        EasyLoading.showSuccess('Berhasil ubah jadwal');

        Get.back(result: true);
      } catch (err) {
        print(err);
        if (err is DioError) {
          var message = err.response?.data?['message'] ?? defaultErrorMessage;
          EasyLoading.showError(message);
          return;
        }
        EasyLoading.showError(defaultErrorMessage);
        return;
      }
    } else {
      debugPrint(formKey.currentState?.value.toString());
      debugPrint('validation failed');
    }
  }

  void onChangeTipeJadwal(String value) {
    selectedTipe.value = value;
  }

  String defaultSelected(List<Workday>? workdays, String day) {
    String mapWorkdays = AppUtils.mapWorkdays(workdays, day);
    String defaultValue = mapWorkdays.isEmpty ? options[0].value : mapWorkdays;
    return defaultValue;
  }

  String selectedSenin(List<Workday>? workdays) {
    String mapWorkdays = AppUtils.mapWorkdays(workdays, '1');
    String defaultValue = mapWorkdays.isEmpty ? options[0].value : mapWorkdays;
    return valueSenin.value.isNotEmpty ? valueSenin.value : defaultValue;
  }

  String selectedSelasa(List<Workday>? workdays) {
    String mapWorkdays = AppUtils.mapWorkdays(workdays, '2');
    String defaultValue = mapWorkdays.isEmpty ? options[0].value : mapWorkdays;
    return valueSelasa.value.isNotEmpty ? valueSelasa.value : defaultValue;
  }

  String selectedRabu(List<Workday>? workdays) {
    String mapWorkdays = AppUtils.mapWorkdays(workdays, '3');
    String defaultValue = mapWorkdays.isEmpty ? options[0].value : mapWorkdays;
    return valueRabu.value.isNotEmpty ? valueRabu.value : defaultValue;
  }

  String selectedKamis(List<Workday>? workdays) {
    String mapWorkdays = AppUtils.mapWorkdays(workdays, '4');
    String defaultValue = mapWorkdays.isEmpty ? options[0].value : mapWorkdays;
    return valueKamis.value.isNotEmpty ? valueKamis.value : defaultValue;
  }

  String selectedJumat(List<Workday>? workdays) {
    String mapWorkdays = AppUtils.mapWorkdays(workdays, '5');
    String defaultValue = mapWorkdays.isEmpty ? options[0].value : mapWorkdays;
    return valueJumat.value.isNotEmpty ? valueJumat.value : defaultValue;
  }

  String selectedSabtu(List<Workday>? workdays) {
    String mapWorkdays = AppUtils.mapWorkdays(workdays, '6');
    String defaultValue = mapWorkdays.isEmpty ? options[0].value : mapWorkdays;
    return valueSabtu.value.isNotEmpty ? valueSabtu.value : defaultValue;
  }

  String selectedMinggu(List<Workday>? workdays) {
    String mapWorkdays = AppUtils.mapWorkdays(workdays, '7');
    String defaultValue = mapWorkdays.isEmpty ? options[0].value : mapWorkdays;
    return valueMinggu.value.isNotEmpty ? valueMinggu.value : defaultValue;
  }

  void onSelectedMinggu(String value, String day) {
    valueMinggu.value = value;
    selectedWorkday.addAll({day: value});
  }

  void onSelectedSenin(String value, String day) {
    valueSenin.value = value;
    selectedWorkday.addAll({day: value});
  }

  void onSelectedSelasa(String value, String day) {
    valueSelasa.value = value;
    selectedWorkday.addAll({day: value});
  }

  void onSelectedRabu(String value, String day) {
    valueRabu.value = value;
    selectedWorkday.addAll({day: value});
  }

  void onSelectedKamis(String value, String day) {
    valueKamis.value = value;
    selectedWorkday.addAll({day: value});
  }

  void onSelectedJumat(String value, String day) {
    valueJumat.value = value;
    selectedWorkday.addAll({day: value});
  }

  void onSelectedSabtu(String value, String day) {
    valueSabtu.value = value;
    selectedWorkday.addAll({day: value});
  }
}
