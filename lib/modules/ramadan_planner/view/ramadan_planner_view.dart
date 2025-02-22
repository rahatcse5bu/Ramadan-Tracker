import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../Credit.dart';
import '../../../Tracking-Old.dart';
import '../../../app/constants/app_color.dart';
import '../../../widgets/Good_Afternoon_Todo.dart';
import '../controller/ramadan_planner_controller.dart';
import 'package:expandable_text/expandable_text.dart';

import '../widgets/achievement_card_widget.dart';
import '../widgets/asmaul_husna_widget.dart';
import '../widgets/tracking_widget.dart';

class RamadanPlannerView extends GetView<RamadanPlannerController> {
  @override
  Widget build(BuildContext context) {
    int ramadanDay = Get.arguments['ramadan_day'] ?? 1;
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          margin: EdgeInsets.fromLTRB(10.w, 0, 2.w, 0),
          child: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              // Navigate to LoginScreen or previous screen
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ),
        backgroundColor: AppColors.primary,
        title: Text(
          '$ramadanDay রমাদ্বন ${controller.currentYear.value}',
          style: TextStyle(color: Colors.white, fontSize: 18.sp),
        ),
        centerTitle: true,
      ),
      body: Obx(() => SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
            child: Column(
              children: [
                SizedBox(height: 10.h),
                // Points Card
                Card(
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(6.r),
                            topRight: Radius.circular(6.r)),
                        color: AppColors.primary,
                      ),
                      width: 1.sw,
                      padding: EdgeInsets.symmetric(
                          vertical: 30.h, horizontal: 10.w),
                      child: Text(
                        "আজকের পয়েন্ট: ${controller.todaysPoint.value}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.sp,
                            color: Colors.white),
                      )),
                ),
                SizedBox(height: 10.h),
                // Hadith and Ayat Cards
                Column(
                  children: [
                    Card(
                      elevation: 5,
                      child: Padding(
                        padding: EdgeInsets.all(10.h),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.h, horizontal: 10.w),
                              margin: EdgeInsets.only(bottom: 5.h),
                              width: 1.sw,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(6.r),
                                    topRight: Radius.circular(6.r)),
                                color: AppColors.primary,
                              ),
                              child: Center(
                                child: Text(
                                  "আজকের হাদিস",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 20.sp),
                                ),
                              ),
                            ),
                            controller.isLoadingHadith.value
                                ? Center(
                                    child: CircularProgressIndicator(
                                        color: AppColors.primary))
                                : ExpandableText(
                                    controller.ajkerHadith.value,
                                    expandText: 'show more',
                                    collapseText: 'show less',
                                    maxLines: 4,
                                    linkColor: Colors.blue,
                                    style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontSize: 12.sp),
                                  )
                          ],
                        ),
                      ),
                    ),
                    Card(
                      elevation: 5,
                      child: Padding(
                        padding: EdgeInsets.all(10.h),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.h, horizontal: 10.w),
                              margin: EdgeInsets.only(bottom: 5.h),
                              width: 1.sw,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(6.r),
                                    topRight: Radius.circular(6.r)),
                                color: AppColors.primary,
                              ),
                              child: Center(
                                child: Text(
                                  "আজকের আয়াত",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.sp,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            controller.isLoadingAyat.value
                                ? Center(
                                    child: CircularProgressIndicator(
                                        color: AppColors.primary))
                                : ExpandableText(
                                    controller.ajkerAyat.value,
                                    expandText: 'show more',
                                    collapseText: 'show less',
                                    maxLines: 4,
                                    linkColor: Colors.blue,
                                    style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontSize: 12.sp),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                // Tracking Widgets
                if (ramadanDay > 20)
                  TrackingWidget(
                      ramadan_day: ramadanDay,
                      type: 'switch',
                      slug: 'qadr_tracking'),
                TrackingWidget(
                    ramadan_day: ramadanDay,
                    type: 'switch',
                    slug: 'night_tracking'),
                TrackingWidget(
                    ramadan_day: ramadanDay,
                    type: 'checkbox',
                    slug: 'fajr_tracking'),
                TrackingWidget(
                    ramadan_day: ramadanDay,
                    type: 'switch',
                    slug: 'zuhr_tracking'),
                // Dua Card
                Column(
                  children: [
                    Card(
                      elevation: 5,
                      child: Padding(
                        padding: EdgeInsets.all(10.h),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.h, horizontal: 10.w),
                              margin: EdgeInsets.only(bottom: 5.h),
                              width: 1.sw,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(6.r),
                                    topRight: Radius.circular(6.r)),
                                color: AppColors.primary,
                              ),
                              child: Center(
                                child: Text(
                                  "আজকের দু'আ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.sp,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(height: 10.h),
                            controller.isLoadingDua.value
                                ? Center(
                                    child: CircularProgressIndicator(
                                        color: AppColors.primary))
                                : Text(
                                    controller.ajkerDuaTitle.value,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.sp,
                                        color: Colors.black),
                                  ),
                            SizedBox(height: 10.h),
                            controller.isLoadingDua.value
                                ? Center(
                                    child: CircularProgressIndicator(
                                        color: AppColors.primary))
                                : ExpandableText(
                                    controller.ajkerDuaArabic.value,
                                    expandText: 'show more',
                                    collapseText: 'show less',
                                    maxLines: 4,
                                    linkColor: AppColors.primary,
                                    style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontSize: 12.sp),
                                  ),
                            SizedBox(height: 10.h),
                            controller.isLoadingDua.value
                                ? Center(
                                    child: CircularProgressIndicator(
                                        color: AppColors.primary))
                                : ExpandableText(
                                    controller.ajkerDuaBangla.value,
                                    expandText: 'show more',
                                    collapseText: 'show less',
                                    maxLines: 4,
                                    linkColor: AppColors.primary,
                                    style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontSize: 12.sp),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                // Additional Tracking Widgets
                TrackingWidget(
                    ramadan_day: ramadanDay,
                    type: 'switch',
                    slug: 'general_tracking'),
                Good_Afternoon_Todo(ramadan_day: ramadanDay),

                TrackingWidget(
                    ramadan_day: ramadanDay,
                    type: 'switch',
                    slug: 'asr_tracking'),
                TrackingWidget(
                    ramadan_day: ramadanDay,
                    type: 'checkbox',
                    slug: 'evening_tracking'),
                SizedBox(height: 10.h),
                // Asmaul Husna & Credit
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                  margin: EdgeInsets.only(bottom: 5.h),
                  width: 1.sw,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(60.r),
                          topRight: Radius.circular(60.r)),
                      color: AppColors.primary),
                  child: Center(
                      child: Text("আসমাউল হুসনা:",
                          style:
                              TextStyle(fontSize: 25.sp, color: Colors.white))),
                ),
                AsmaulHusnaWidget(),
                // // Special Achievement Card
                AchievementWidget(ramadan_day: ramadanDay),
                // // Credit Widget
                Credit(),
              ],
            ),
          )),
    );
  }
}
