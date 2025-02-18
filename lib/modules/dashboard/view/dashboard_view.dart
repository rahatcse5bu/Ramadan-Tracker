import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ramadan_tracker/modules/dashboard/widgets/leaderboard_widget.dart';
import 'package:ramadan_tracker/modules/dashboard/widgets/quote_widget.dart';
import 'package:ramadan_tracker/modules/dashboard/widgets/ramadan_days_list.dart';

import '../../../app/constants/app_color.dart';
import '../controller/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(
              "রমাদ্বন ট্রাকার [\${controller.totalPoints} pts]",
              style: TextStyle(fontSize: 16, color: Colors.white),
            )),
        backgroundColor: AppColors.primary,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.white),
            onPressed: controller.logout,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            LeaderboardWidget(),
            QuoteWidget(title: "নির্বাচিত আয়াত", text: controller.ajkerAyat.value),
            QuoteWidget(title: "নির্বাচিত হাদিস", text: controller.ajkerHadith.value),
            QuoteWidget(title: "সালাফদের বক্তব্য", text: controller.ajkerSalafQuote.value),
            RamadanDaysList(),
          ],
        ),
      ),
    );
  }
}
