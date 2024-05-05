import 'package:awesome_select/awesome_select.dart';
import 'package:get/get.dart';

import '../../models/user.model.dart';
import '../../services/shifting.service.dart';

class WorkdaysController extends GetxController {
  var loading = false.obs;
  var valueSenin = ''.obs;
  var valueSelasa = ''.obs;
  var valueRabu = ''.obs;
  var valueKamis = ''.obs;
  var valueJumat = ''.obs;
  var valueSabtu = ''.obs;
  var valueMinggu = ''.obs;
  var dumlist = [];
  var options = <S2Choice<String>>[].obs;
  var userUp = <User>[].obs;
  var selectedWorkday = {}.obs;

  @override
  void onInit() {
    super.onInit();
    getShiftingList();
  }

  void setLoading(bool value) {
    loading.value = value;
  }

  Future<void> getShiftingList() async {
    setLoading(true);

    final shifting = await ShiftingService().find({});

    options.value = shifting.data!.map((element) {
      return S2Choice<String>(value: element.id!, title: element.name);
    }).toList();
    options.add(S2Choice<String>(value: '2', title: 'Libur'));
    options.refresh();

    setLoading(false);
  }

  void onSelectedWorkday(String value, String day) {
    valueSenin.value = value;
    selectedWorkday.addAll({day: value});
  }
}
