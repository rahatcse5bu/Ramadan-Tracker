import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ramadan_tracker/app/common/storage/storage_controller.dart';
import 'package:ramadan_tracker/modules/dashboard/widgets/leaderboard_widget.dart';
import 'package:ramadan_tracker/modules/dashboard/widgets/quote_widget.dart';
import 'package:ramadan_tracker/modules/dashboard/widgets/ramadan_days_list.dart';

import '../../../app/constants/app_color.dart';
import '../../../app/routes/app_pages.dart';
import '../controller/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => controller.isLoading.value
            ? CircularProgressIndicator(
                color: Colors.white,
              )
            : Text("রমাদ্বন ট্রাকার [${controller.totalPoints.value} pts]",
                style: TextStyle(fontSize: 16, color: Colors.white))),
        backgroundColor: AppColors.primary, // Change to your primary color
        centerTitle: true,
        leadingWidth: 105,
        leading: Obx(() => Center(
              child: Container(
                  padding: EdgeInsets.only(left: 0),
                  // width: 800,
                  child: Text(
                    "Rank:${controller.userRank.value}",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  )),
            )),
        actions: <Widget>[
          PopupMenuButton(
            color: Colors.white,
            icon: Icon(
              Icons.more_vert,
              color: Colors
                  .white, // Change the color of the vertical three dots here
            ),
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  child: InkWell(
                    onTap: () async {
// Ensure the LocalStorage is ready before setting items

                      StorageHelper.removeToken();
                      StorageHelper.removeFullName();
                      StorageHelper.removeUserData();
                      StorageHelper.removeUserId();
                      StorageHelper.removeUserName();

                      // Redirect to login page
                      Get.toNamed(Routes.login);
                    },
                    child: Column(
                      children: [
                        Text(StorageHelper.getFullName() as String),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.logout,
                          color: Colors.white,
                        ),
                        SizedBox(width: 10),
                        Text('Logout'),
                      ],
                    ),
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Obx(
          () => Column(
            children: [
              LeaderboardWidget(),
              QuoteWidget(
                  title: "নির্বাচিত আয়াত",
                  text: controller.ajkerAyat.value,
                  type: 'ajker_ayat'),
              QuoteWidget(
                  title: "নির্বাচিত হাদিস",
                  text: controller.ajkerHadith.value,
                  type: 'ajker_hadith'),
              QuoteWidget(
                  title: "সালাফদের বক্তব্য",
                  text: controller.ajkerSalafQuote.value,
                  type: 'salaf_quote'),
              RamadanDaysList(),
            ],
          ),
        ),
      ),
    );
  }
}
