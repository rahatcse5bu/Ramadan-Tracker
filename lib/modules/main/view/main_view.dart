// 4. Implement in View
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/common/controller/nav_controller.dart';
import '../../../app/common/widgets/custom_appbar_widget.dart';
import '../../../app/constants/app_color.dart';
import '../../../app/translation/translation_keys.dart';
import '../../dashboard/controller/dashboard_controller.dart';
import '../../dashboard/view/dashboard_view.dart';
import '../../dashboard/widgets/leaderboard_widget.dart';

class MainView extends StatelessWidget {
  final NavController controller = Get.put(NavController());
  final DashboardController dashboardController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.appBar(title: ''),
      body: Obx(() {
        switch (controller.currentIndex.value) {
          case 0:
            return DashboardView();
          case 1:
            return LeaderboardWidget(isLeaderboardPage: true,);
          case 2:
            // return DuasScreen();
          default:
            return DashboardView();
        }
      }),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          backgroundColor: Colors.white,
          currentIndex: controller.currentIndex.value,
          onTap: controller.changeTab,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: TranslationKeys.home.tr,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.leaderboard),
              label: TranslationKeys.leaderBoard.tr,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: TranslationKeys.duas.tr,
            ),
          ],
          selectedItemColor: AppColors.primary,
          unselectedItemColor: Colors.grey,
        ),
      ),
    );
  }
}