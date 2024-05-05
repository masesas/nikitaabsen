import 'package:awesome_select/awesome_select.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import '../../models/user.model.dart';
import '../../services/schedule.service.dart';
import '../../services/shifting.service.dart';
import '../../utils/app_utils.dart';
import '../../utils/constants.dart';

class HariKerjaController extends GetxController {
  final newJadwalFormKey = GlobalKey<FormBuilderState>();

  var loading = false.obs;
  var valueSenin = ''.obs;
  var valueSelasa = ''.obs;
  var valueRabu = ''.obs;
  var valueKamis = ''.obs;
  var valueJumat = ''.obs;
  var valueSabtu = ''.obs;
  var valueMinggu = ''.obs;
  var selectedTipe = ''.obs;
  var dumlist = [];

  var options = <S2Choice<String>>[].obs;
  var userUp = <User>[].obs;
  Map<String, dynamic> selectedWorkday = {};

  @override
  void onInit() {
    super.onInit();
    getShiftingList();
  }

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

    options.refresh();

    initSelectedWorkday();

    setLoading(false);
  }

  List mappingWorkdayList() {
    List workdayList = [];

    selectedWorkday.forEach((key, value) {
      workdayList.add(
        {
          'name': AppUtils.mapDays(key),
          'day': key,
          'shifting_id': value,
        },
      );
    });

    return workdayList;
  }

  void handleSubmitWorkday() {
    print(selectedWorkday);
    Get.back(result: selectedWorkday);
  }

  void handleSubmitSchedule() async {
    if (newJadwalFormKey.currentState?.saveAndValidate() ?? false) {
      EasyLoading.show();

      var user = AppUtils.getUser();
      var formData = newJadwalFormKey.currentState?.value;

      try {
        Map<String, dynamic> body = {
          'name': formData?['nama_jadwal'],
          'type': selectedTipe.value,
          'effective_date': formData?['effective_date'].toString(),
          'company_id': user.companyId,
          'workday': mappingWorkdayList()
        };

        print(body);

        await ScheduleService().create(body);

        EasyLoading.showSuccess('Berhasil tambah jadwal');

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
      debugPrint(newJadwalFormKey.currentState?.value.toString());
      debugPrint('validation failed');
    }
  }

  void onChangeTipeJadwal(String value) {
    selectedTipe.value = value;
  }

  String selectedSenin() {
    return valueSenin.value.isNotEmpty ? valueSenin.value : options[0].value;
  }

  String selectedSelasa() {
    return valueSelasa.value.isNotEmpty ? valueSelasa.value : options[0].value;
  }

  String selectedRabu() {
    return valueRabu.value.isNotEmpty ? valueRabu.value : options[0].value;
  }

  String selectedKamis() {
    return valueKamis.value.isNotEmpty ? valueKamis.value : options[0].value;
  }

  String selectedJumat() {
    return valueJumat.value.isNotEmpty ? valueJumat.value : options[0].value;
  }

  String selectedSabtu() {
    return valueSabtu.value.isNotEmpty ? valueSabtu.value : options[0].value;
  }

  String selectedMinggu() {
    return valueMinggu.value.isNotEmpty ? valueMinggu.value : options[0].value;
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
