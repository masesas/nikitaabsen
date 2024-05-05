import 'package:get/get.dart';
import 'package:nikitaabsen/models/response/leave_type_response.dart';
import 'package:nikitaabsen/services/leave_type.service.dart';

class LeaveFormController extends GetxController {
  var leaveTypes = LeaveTypeResponse().obs;
  var loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    setLeaveTypes();
  }

  void setLoading(bool value) {
    loading.value = value;
  }

  Future<void> setLeaveTypes() async {
    print('trigger');
    setLoading(true);
    var response = await LeaveTypeService().find({});
    leaveTypes.update((val) {
      val!.data = response.data;
      val.total = response.total;
      val.skip = response.skip;
      val.limit = response.limit;
    });
    setLoading(false);
  }
}
