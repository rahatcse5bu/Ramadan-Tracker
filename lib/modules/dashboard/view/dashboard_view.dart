import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ramadan_tracker/app/common/storage/storage_controller.dart';
import 'package:ramadan_tracker/app/common/utils/ramadan_utils.dart';
import 'package:ramadan_tracker/modules/dashboard/widgets/leaderboard_widget.dart';
import 'package:ramadan_tracker/modules/dashboard/widgets/quote_widget.dart';
import 'package:ramadan_tracker/modules/dashboard/widgets/ramadan_days_list.dart';

import '../../../app/constants/app_color.dart';
import '../../../app/routes/app_pages.dart';
import '../../../app/translation/language_controller.dart';
import '../../../app/translation/translation_keys.dart';
import '../controller/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//       appBar: AppBar(
//         title: Obx(() => controller.isLoading.value
//             ? CupertinoActivityIndicator(color: AppColors.primary,)
//             : Text("${controller.totalPoints.value} pts",
//                 style: TextStyle(fontSize: 16, color: Colors.white))),
//         backgroundColor: AppColors.primary, // Change to your primary color
//         centerTitle: true,
//         leadingWidth: 105,
//         leading: Obx(() => controller.isLoading.value
//             ? CupertinoActivityIndicator(color: AppColors.primary,)
//             : Center(
//               child: Container(
//                   padding: EdgeInsets.only(left: 0),
//                   // width: 800,
//                   child: Text(
//                     "${TranslationKeys.rank.tr}:${controller.userRank.value}",
//                     style: TextStyle(fontSize: 16, color: Colors.white),
//                   )),
//             )),
//         actions: <Widget>[
//           // In your settings screen/widget
//           GetBuilder<LanguageController>(
//             builder: (controller) {
//               return DropdownButtonHideUnderline(

//                 child: DropdownButton<String>(

//                   value: controller.appLocale?.languageCode ?? 'en',
//                   // icon: Icon(Icons.language, color: Colors.white),
//                   // isExpanded: true,
//                   dropdownColor: AppColors.primary,

//                   borderRadius: BorderRadius.circular(12),
//                   style: TextStyle(
//                     fontSize: 12.sp,
//                     color: Colors.black,
//                     fontWeight: FontWeight.w500,
//                   ),
//                   onChanged: (String? newValue) {
//                     if (newValue != null) {
//                       controller.changeLanguage(
//                         newValue,
//                         newValue == 'bn' ? 'BD' : 'US',
//                       );
//                     }
//                   },
//                   items: [
//                     DropdownMenuItem(
//                       value: 'en',
//                       child: Row(
//                         children: [
//                           Text('🇺🇸'), // Optional flag icon
//                           SizedBox(width: 5.w),
//                           Text(
//                             'English',
//                             style:
//                                 TextStyle(color: Colors.white, fontSize: 11.sp),
//                           ),
//                         ],
//                       ),
//                     ),
//                     DropdownMenuItem(

//                       value: 'bn',
//                       child: Row(
//                         children: [
//                           Text('🇧🇩'), // Optional flag icon
//                           SizedBox(width: 5.w),
//                           Text('বাংলা', style:
//                                 TextStyle(color: Colors.white, fontSize: 11.sp),),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//           PopupMenuButton(
//             color: Colors.white,
//             icon: Icon(
//               Icons.more_vert,
//               color: Colors
//                   .white, // Change the color of the vertical three dots here
//             ),
//             itemBuilder: (BuildContext context) {
//               return [
//                 // Language Selection Items
//                 // PopupMenuItem(
//                 //   child: GetBuilder<LanguageController>(
//                 //     builder: (controller) {
//                 //       return Column(
//                 //         children: [
//                 //           _buildLanguageItem(context,
//                 //               languageCode: 'en', label: 'English'),
//                 //           _buildLanguageItem(context,
//                 //               languageCode: 'bn', label: 'বাংলা'),
//                 //         ],
//                 //       );
//                 //     },
//                 //   ),
//                 // ),
//                 PopupMenuItem(
//                   child: InkWell(
//                     onTap: () async {
// // Ensure the LocalStorage is ready before setting items

//                       StorageHelper.removeToken();
//                       StorageHelper.removeFullName();
//                       StorageHelper.removeUserData();
//                       StorageHelper.removeUserId();
//                       StorageHelper.removeUserName();

//                       // Redirect to login page
//                       Get.toNamed(Routes.login);
//                     },
//                     child: Column(
//                       children: [
//                         Text(controller.username.value),
//                         SizedBox(
//                           width: 10,
//                         ),
//                         Icon(
//                           Icons.logout,
//                           color: Colors.white,
//                         ),
//                         SizedBox(width: 10),
//                         Text('Logout'),
//                       ],
//                     ),
//                   ),
//                 ),
//               ];
//             },
//           ),
//         ],
//       ),
      body: SingleChildScrollView( 
        child: Obx(
          () => Column(
            children: [
              LeaderboardWidget(),
              QuoteWidget(
                  title: TranslationKeys.selectedVerses.tr,
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
              // Text("${TranslationKeys.selectedVerses.tr}"),
              RamadanDaysList(),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildLanguageItem(
  BuildContext context, {
  required String languageCode,
  required String label,
}) {
  final controller = Get.find<LanguageController>();

  return Obx(() {
    final bool isSelected = controller.appLocale?.languageCode == languageCode;

    return InkWell(
      onTap: () => controller.changeLanguage(
          languageCode, languageCode == 'bn' ? 'BD' : 'US'),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                color: isSelected ? Colors.green : Colors.black,
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 20,
              ),
          ],
        ),
      ),
    );
  });
}
