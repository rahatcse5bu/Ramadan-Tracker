import 'package:get/get.dart';

import '../controller/dashboard_controller.dart';
import '../controller/user_points_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserPointsController>(() => UserPointsController());
    Get.lazyPut<DashboardController>(() => DashboardController());
  }
}
