import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../modules/dashboard/controller/dashboard_controller.dart';
import '../../constants/app_color.dart';
import '../../routes/app_pages.dart';
import '../../translation/language_controller.dart';
import '../../translation/translation_keys.dart';
import '../controller/app_controller.dart';
import '../storage/storage_controller.dart';
import '../utils/ramadan_utils.dart';

class CustomAppBar {
  // Static method to create a custom app bar
  static PreferredSizeWidget appBar({
    required String title,
    bool centerTitle = true,
    Color? backgroundColor,
    Color? titleColor,
    String? name,
    List<Widget>? actions,
    IconData? leadingIcon,
    Widget? leadingWidget,
    double? leadingWidth,
    String? profilePicture,
    VoidCallback? onLeadingPressed,
  }) {
    // final AppController appController = Utils.getAppController();
    final DashboardController dashboardController = Get.find();
    final LanguageController languageController = Get.find();

    return AppBar(
      scrolledUnderElevation: 0,
      leadingWidth: leadingWidth ?? 180,
      title: Obx(() => dashboardController.isLoading.value
          ? CupertinoActivityIndicator(
              color: AppColors.primary,
            )
          : Text("${dashboardController.totalPoints.value} pts",
              style: TextStyle(fontSize: 16, color: Colors.white))),
      centerTitle: centerTitle,
      backgroundColor: backgroundColor ?? AppColors.primary,
      automaticallyImplyLeading: true,
      actions: actions ??
          <Widget>[
            // In your settings screen/widget
            GetBuilder<LanguageController>(
              builder: (controller) {
                return DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: controller.appLocale?.languageCode ?? 'en',
                    // icon: Icon(Icons.language, color: Colors.white),
                    // isExpanded: true,
                    dropdownColor: AppColors.primary,

                    borderRadius: BorderRadius.circular(12),
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        controller.changeLanguage(
                          newValue,
                          newValue == 'bn' ? 'BD' : 'US',
                        );
                      }
                    },
                    items: [
                      DropdownMenuItem(
                        value: 'en',
                        child: Row(
                          children: [
                            Text('🇺🇸'), // Optional flag icon
                            SizedBox(width: 5.w),
                            Text(
                              'English',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 11.sp),
                            ),
                          ],
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'bn',
                        child: Row(
                          children: [
                            Text('🇧🇩'), // Optional flag icon
                            SizedBox(width: 5.w),
                            Text(
                              'বাংলা',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 11.sp),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            PopupMenuButton(
              color: Colors.white,
              icon: Icon(
                Icons.more_vert,
                color: Colors
                    .white, // Change the color of the vertical three dots here
              ),
              itemBuilder: (BuildContext context) {
                return [
                  // Language Selection Items
                  // PopupMenuItem(
                  //   child: GetBuilder<LanguageController>(
                  //     builder: (controller) {
                  //       return Column(
                  //         children: [
                  //           _buildLanguageItem(context,
                  //               languageCode: 'en', label: 'English'),
                  //           _buildLanguageItem(context,
                  //               languageCode: 'bn', label: 'বাংলা'),
                  //         ],
                  //       );
                  //     },
                  //   ),
                  // ),
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
                          Text(dashboardController.username.value),
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
      leading: leadingWidget ??
          Obx(() => dashboardController.isLoading.value
              ? CupertinoActivityIndicator(
                  color: AppColors.primary,
                )
              : Center(
                  child: Container(
                      padding: EdgeInsets.only(left: 0),
                      // width: 800,
                      child: Text(
                        "${TranslationKeys.rank.tr}:${dashboardController.userRank.value}",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      )),
                )),
    );
  }
}
