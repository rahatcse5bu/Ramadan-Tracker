// 4. Implement in View
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../app/common/controller/nav_controller.dart';
import '../../../app/common/widgets/custom_appbar_widget.dart';
import '../../../app/constants/app_color.dart';
import '../../../app/routes/app_pages.dart';
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
            return LeaderboardWidget(
              isLeaderboardPage: true,
            );
          case 2:
            return Wrap();

          default:
            return DashboardView();
        }
      }),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          // iconSize: 16.sp,
          // unselectedLabelStyle: TextStyle(fontSize: 11.sp),
          backgroundColor: Colors.white,
          currentIndex: controller.currentIndex.value,
          showSelectedLabels: true,
          // onTap: controller.changeTab,
          onTap: (index) {
            if (index == 2) {
              _openMoreBottomSheet();
            } else {
              controller.changeTab(index);
            }
          },
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
              icon: Icon(Icons.more_horiz),
              label: TranslationKeys.more.tr,
            ),
          ],
          selectedItemColor: AppColors.primary,
          unselectedItemColor: Colors.grey,
        ),
      ),
    );
  }
}

void _openMoreBottomSheet() {
  Get.bottomSheet(
    Container(
      padding: EdgeInsets.all(16), // ✅ Add padding for better UX
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Wrap( // ✅ Auto-wrap if items exceed screen width
        spacing: 8.w, // ✅ Horizontal spacing
        runSpacing: 8.h, // ✅ Vertical spacing
        alignment: WrapAlignment.center, // ✅ Center items
        children: [
          _buildBottomSheetItem(
              TranslationKeys.koroniyo.tr, Icons.check_circle),
          _buildBottomSheetItem(TranslationKeys.borjoniyo.tr, Icons.cancel),
          _buildBottomSheetItem(TranslationKeys.duas.tr, Icons.book),
        ],
      ),
    ),
    enableDrag: true,
  );
}

/// **Build Bottom Sheet Item**
Widget _buildBottomSheetItem(String title, IconData icon) {
  return GestureDetector(
    onTap: () {
      Get.back(); // ✅ Close bottom sheet before navigating
      _navigateTo(title); // ✅ Navigate based on title
    },
    child: Column(
      children: [
        Card( // ✅ Use Card for better UI
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Icon(icon, color: AppColors.primary),
                SizedBox(width: 8.w),
                Text(title, style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

/// **Handle Navigation Based on Title**
void _navigateTo(String title) {
  if (title == TranslationKeys.koroniyo.tr) {
    Get.toNamed('/koroniyo');
  } else if (title == TranslationKeys.borjoniyo.tr) {
    Get.toNamed(Routes.borjoniyo);
  } else if (title == TranslationKeys.duas.tr) {
    Get.toNamed('/duas');
  }
}
