import 'package:get/get.dart';
import 'package:localstorage/localstorage.dart';
import '../../../app/apis/api_helper.dart';


class UserPointsController extends GetxController {
  final LocalStorage storage = LocalStorage('ramadan_tracker');
  final ApiHelper _apiHelper = Get.find<ApiHelper>();

  var todaysPoint = 0.obs;
  var visibleCount = 20.obs;
  var isLoadingPoint = true.obs;
  var isShowAll = false.obs;
  var userRank = 0.obs;
  var users = [].obs;
  var isLoadingUsers = true.obs;
  var totalPoints = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCurrentUserPoints();
  }

  Future<void> fetchTodaysPoint(int ramadanDay) async {
    await storage.ready;
    String? userId = storage.getItem('_id');
    if (userId == null) {
      isLoadingPoint.value = false;
      return;
    }

    isLoadingPoint(true);
    final result = await _apiHelper.fetchTodaysPoint(userId, ramadanDay);
    result.fold(
      (error) => isLoadingPoint(false),
      (points) {
        todaysPoint.value = points;
        isLoadingPoint(false);
      },
    );
  }

  Future<void> fetchCurrentUserPoints() async {
    isLoadingUsers(true);
    final result = await _apiHelper.fetchCurrentUserPoints();
    result.fold(
      (error) {
        isLoadingUsers(false);
        totalPoints.value = 0;
        userRank.value = 0;
      },
      (data) {
        final userId = storage.getItem('_id');
        final List<dynamic> fetchedUsers = data["data"];

        fetchedUsers.sort((a, b) {
          int aPoints = a["totalPoints"] ?? 0;
          int bPoints = b["totalPoints"] ?? 0;
          return bPoints.compareTo(aPoints);
        });

        int currentUserRank = 0;
        for (int i = 0; i < fetchedUsers.length; i++) {
          if (fetchedUsers[i]["user"]["_id"] == userId) {
            currentUserRank = i + 1;
            totalPoints.value = fetchedUsers[i]["totalPoints"] ?? 0;
            break;
          }
        }

        userRank.value = currentUserRank;
        isLoadingUsers(false);
      },
    );
  }

  handleShowAll(){
    isShowAll.value = !isShowAll.value;
  }
}
