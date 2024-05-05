import 'package:awesome_select/awesome_select.dart';
import 'package:get/get.dart';

import '../../../services/schedule.service.dart';

class AssignSelectListController extends GetxController {
  var loading = false.obs;
  var options = <S2Choice<String>>[].obs;
  var selected = {}.obs;

  @override
  void onInit() {
    super.onInit();
    getScheduleList();
  }

  void setLoading(bool value) {
    loading.value = value;
  }

  void onSelectChanged(S2SingleSelected<String> val, String userId) {
    selected.addAll({userId: val.value});
  }

  Future<void> getScheduleList() async {
    setLoading(true);

    final schedule = await ScheduleService().find({});

    options.value = schedule.data!.map((element) {
      return S2Choice<String>(value: element.id!, title: element.name);
    }).toList();

    options.refresh();

    setLoading(false);
  }
}
