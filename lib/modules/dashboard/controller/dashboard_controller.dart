import 'dart:math';
import 'package:get/get.dart';
import 'package:hijri/hijri_calendar.dart';
import '../../../app/apis/api_helper.dart';
import '../../../app/common/storage/storage_controller.dart';
import '../models/user_model.dart';

class DashboardController extends GetxController {
  final ApiHelper _apiHelper = Get.find<ApiHelper>();
  final Random _random = Random();
  var totalPoints = 0.obs;
  var userRank = 0.obs;
  var isLoading = true.obs;
  // var isLoadingAjkerAyat = true.obs;
  var users = <UserModel>[].obs;
  List<int> ramadanList = List.generate(30, (index) => index + 1).obs;
  var ajkerAyat = ''.obs;
  var ajkerHadith = ''.obs;
  var ajkerSalafQuote = ''.obs;
  var current_month = HijriCalendar.now().getLongMonthName();
  var current_date = HijriCalendar.now().hDay;
  // final _random = new Random();
  @override
  void onInit() {
    super.onInit();
    fetchDashboardData();
  }

  Future<void> fetchDashboardData() async {
    isLoading(true);
    await fetchAjkerAyat();
    await fetchAjkerHadith();
    await fetchAjkerSalafQuote();
    await fetchUsers();
    isLoading(false);
  }

  Future<void> fetchAjkerAyat() async {
    final result = await _apiHelper.fetchAjkerAyat();
    result.fold((error) => null, (ayat) => ajkerAyat.value = ayat);
  }

  Future<void> fetchAjkerHadith() async {
    final result = await _apiHelper.fetchAjkerHadith();
    result.fold((error) => null, (hadith) => ajkerHadith.value = hadith);
  }

  Future<void> fetchAjkerSalafQuote() async {
    final result = await _apiHelper.fetchAjkerSalafQuote();
    result.fold((error) => null, (quote) => ajkerSalafQuote.value = quote);
  }

  Future<void> fetchUsers() async {
    final result = await _apiHelper.fetchUsers();
    result.fold((error) => null, (userList) => users.value = userList);
  }

  Future<void> logout() async {
    await StorageHelper.removeUserName();
    await StorageHelper.removeToken();
    await StorageHelper.removeUserData();
    await StorageHelper.removeFullName();
    Get.offAllNamed('/login');
  }
}
