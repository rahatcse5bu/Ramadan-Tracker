import 'package:get/get.dart';
import '../../../app/apis/api_helper.dart';

class MainController extends GetxController {
  final ApiHelper _apiHelper = Get.find<ApiHelper>();

  var isLoading = true.obs;



  @override
  void onInit() {
    super.onInit();
  }
}
