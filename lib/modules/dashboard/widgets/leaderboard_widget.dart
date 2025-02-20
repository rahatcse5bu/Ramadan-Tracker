import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/constants/app_color.dart';
import '../controller/dashboard_controller.dart';

class LeaderboardWidget extends GetView<DashboardController> {
  @override
  Widget build(BuildContext context) {
    return        SingleChildScrollView(
                    child: ExpansionTile(
                      collapsedBackgroundColor: Colors.transparent,
                      collapsedIconColor: Colors.white,
                      // backgroundColor: AppColors.PrimaryColor,
                      iconColor: Colors.white,
                      title: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
                        controller.isLoading.value
                            ? SizedBox(
                                height: 40,
                                child: Center(child: SingleChildScrollView()))
                            : Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 10),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: DataTable(
                                    border: TableBorder.all(
                                        color:
                                            AppColors.primary.withOpacity(
                                                .7)),
                                    headingRowColor:
                                        MaterialStateProperty.all<Color>(
                                            Color.fromARGB(255, 34, 124, 112)),
                                    columns: const <DataColumn>[
                                      DataColumn(
                                          label: Text('Rank',
                                              style: TextStyle(
                                                  color: Colors.white))),
                                      DataColumn(
                                          label: Text('Username',
                                              style: TextStyle(
                                                  color: Colors.white))),
                                      DataColumn(
                                          label: Text('Name',
                                              style: TextStyle(
                                                  color: Colors.white))),
                                      DataColumn(
                                          label: Text('Total Points',
                                              style: TextStyle(
                                                  color: Colors.white))),
                                    ],
                                    rows: List<DataRow>.generate(
                                      // users.length,
                                      _showAll
                                          ? users.length
                                          : (_visibleItemCount < users.length
                                              ? _visibleItemCount
                                              : users.length),
                                      (index) {
                                        final user = users[index][
                                            'user']; // Adjust according to your actual structure
                                        bool isCurrentUser = user['userName'] ==
                                            userName; // Determine if this row represents the current user
                                        return DataRow(
                                          cells: [
                                            DataCell(Text('${index + 1}',
                                                style: isCurrentUser
                                                    ? TextStyle(
                                                        color: AppColors.primary,
                                                        fontWeight:
                                                            FontWeight.bold)
                                                    : null)),
                                            DataCell(Text(
                                                user['userName'] ?? 'N/A',
                                                style: isCurrentUser
                                                    ? TextStyle(
                                                        color: AppColors.primary,
                                                        fontWeight:
                                                            FontWeight.bold)
                                                    : null)),
                                            DataCell(Text(
                                                user['fullName'] ?? 'N/A',
                                                style: isCurrentUser
                                                    ? TextStyle(
                                                        color: AppColors.primary,
                                                        fontWeight:
                                                            FontWeight.bold)
                                                    : null)),
                                            DataCell(Text(
                                                '${users[index]['totalPoints']}',
                                                style: isCurrentUser
                                                    ? TextStyle(
                                                        color: AppColors.primary,
                                                        fontWeight:
                                                            FontWeight.bold)
                                                    : null)),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                        if (users.length > _visibleItemCount || _showAll)
                          Center(
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  _showAll = !_showAll;
                                });
                              },
                              child: Text(
                                _showAll ? "Show Less" : "Show More",
                                style: TextStyle(color: AppColors.primary),
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
  }
}
