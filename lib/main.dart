import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'app/common/binding/global_binding.dart';
import 'app/routes/app_pages.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
        );
      },
    );
  }
}
