import 'package:get/get.dart';
import 'package:ramadan_tracker/modules/ramadan_planner/controller/ramadan_planner_controller.dart';

class RamadanPlannerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RamadanPlannerController>(() => RamadanPlannerController());
  }
}
