import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../app/apis/api_helper.dart';
import '../../../app/constants/app_color.dart';
import '../../../app/routes/app_pages.dart';
import '../../../app/translation/translation_keys.dart';

class MainController extends GetxController {
  final ApiHelper _apiHelper = Get.find<ApiHelper>();

  var isLoading = true.obs;



  @override
  void onInit() {
    super.onInit();
  }

  void openMoreBottomSheet() {
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
    Get.toNamed(Routes.koroniyo);
  } else if (title == TranslationKeys.borjoniyo.tr) {
    Get.toNamed(Routes.borjoniyo);
  } else if (title == TranslationKeys.duas.tr) {
    Get.toNamed(Routes.duaList);
  }
}

}
