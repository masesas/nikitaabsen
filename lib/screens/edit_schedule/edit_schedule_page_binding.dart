import 'package:get/get.dart';

import 'edit_schedule.controller.dart';

class ProfilePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditScheduleController());
  }
}
