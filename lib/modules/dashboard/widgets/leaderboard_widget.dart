import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ramadan_tracker/app/common/storage/storage_controller.dart';
import 'package:ramadan_tracker/modules/dashboard/controller/user_points_controller.dart';

import '../../../app/constants/app_color.dart';
import '../controller/dashboard_controller.dart';

class LeaderboardWidget extends GetView<UserPointsController> {
  final DashboardController _dashboardController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(() => SingleChildScrollView(
          child: ExpansionTile(
            collapsedBackgroundColor: Colors.transparent,
            collapsedIconColor: Colors.white,
            // backgroundColor: AppColors.PrimaryColor,
            iconColor: Colors.white,
            title: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              margin: EdgeInsets.only(bottom: 5),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(6),
                      topRight: Radius.circular(6)),
                  color: AppColors.primary),
              child: Center(
                child: Text(
                  "লিডারবোর্ড:",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white),
                ),
              ),
            ),
            subtitle: Center(
                child: Text(
              "কোনো আমাল এই পয়েন্ট দিয়ে সাব্যস্ত করার অধিকার কারোর-ই নেই।জাস্ট নিজের আমাল জাজ করার জন্যই এটি দেওয়া। নিয়ত করবেন সওয়াবের, আল্লাহ্‌ প্রতিদান দিবেন ইনশাআল্লাহ্‌!(লিডারবোর্ড দেখতে ডানপাশের অ্যারো বাটনে ক্লিক করুন)",
              style: TextStyle(color: AppColors.primary),
            )),
            trailing: Icon(Icons.arrow_drop_down_circle,
                color: AppColors.primary, size: 30),

            children: [
              _dashboardController.isLoading.value
                  ? SizedBox(
                      height: 40, child: Center(child: SingleChildScrollView()))
                  : Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          border: TableBorder.all(
                              color: AppColors.primary.withOpacity(.7)),
                          headingRowColor: MaterialStateProperty.all<Color>(
                              Color.fromARGB(255, 34, 124, 112)),
                          columns: const <DataColumn>[
                            DataColumn(
                                label: Text('Rank',
                                    style: TextStyle(color: Colors.white))),
                            DataColumn(
                                label: Text('Username',
                                    style: TextStyle(color: Colors.white))),
                            DataColumn(
                                label: Text('Name',
                                    style: TextStyle(color: Colors.white))),
                            DataColumn(
                                label: Text('Total Points',
                                    style: TextStyle(color: Colors.white))),
                          ],
                          rows: List<DataRow>.generate(
                            // users.length,
                            controller.isShowAll.value
                                ? _dashboardController.users.length
                                : (controller.visibleCount.value <
                                        _dashboardController.users.length
                                    ? controller.visibleCount.value
                                    : _dashboardController.users.length),
                            (index) {
                              final user = _dashboardController.users[index]; // Adjust according to your actual structure
                              // log("userrrr: ${user.length}");
                              final currentUser = StorageHelper.getUserName();
                              bool isCurrentUser = user.userName ==
                                  currentUser; // Determine if this row represents the current user
                              return DataRow(
                                cells: [
                                  DataCell(Text('${index + 1}',
                                      style: isCurrentUser
                                          ? TextStyle(
                                              color: AppColors.primary,
                                              fontWeight: FontWeight.bold)
                                          : null)),
                                  DataCell(Text(user.userName ?? 'N/A',
                                      style: isCurrentUser
                                          ? TextStyle(
                                              color: AppColors.primary,
                                              fontWeight: FontWeight.bold)
                                          : null)),
                                  DataCell(Text(user.fullName ?? 'N/A',
                                      style: isCurrentUser
                                          ? TextStyle(
                                              color: AppColors.primary,
                                              fontWeight: FontWeight.bold)
                                          : null)),
                                  DataCell(Text(
                                      '${_dashboardController.users[index].totalPoints}',
                                      style: isCurrentUser
                                          ? TextStyle(
                                              color: AppColors.primary,
                                              fontWeight: FontWeight.bold)
                                          : null)),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ),
              if (_dashboardController.users.length > controller.visibleCount.value ||
                  controller.isShowAll.value)
                Center(
                  child: TextButton(
                    onPressed: () {
                      controller.handleShowAll();
                    },
                    child: Text(
                      controller.isShowAll.value ? "Show Less" : "Show More",
                      style: TextStyle(color: AppColors.primary),
                    ),
                  ),
                ),
            ],
          ),
        ));
  }
}
