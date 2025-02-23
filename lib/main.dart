import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app/common/binding/global_binding.dart';
import 'app/routes/app_pages.dart';
import 'app/translation/app_translation.dart';
import 'app/translation/language_controller.dart';

Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();
  final languageController = Get.put(LanguageController());
  // await languageController.appLocale(); // Load locale before app start
  

  runApp(MyApp());
}
// Function to get saved locale
Future<Locale?> _getSavedLocale() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String? languageCode = prefs.getString('languageCode');
  String? countryCode = prefs.getString('countryCode');
  
  if (languageCode != null && countryCode != null) {
    return Locale(languageCode, countryCode);
  }
  return null;
}
class MyApp extends StatelessWidget {
    final Locale? initialLocale;
  
  const MyApp({Key? key, this.initialLocale}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 690),
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Ramadan Tracker',
          theme: ThemeData(primarySwatch: Colors.blue),
          initialBinding: GlobalBinding(),
          initialRoute: Routes.splash,
          getPages: AppPages.routes,
                    // Localization
          translations: AppTranslation(),
          locale:  Get.find<LanguageController>().appLocale ?? Get.deviceLocale,
          fallbackLocale: const Locale('en', 'US'), // Default to English
          
        );
      },
    );
  }
}
