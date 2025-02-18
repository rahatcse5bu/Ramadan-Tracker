import 'package:get/get.dart';

import '../../splash.dart';

class Routes {
  static const splash = '/splash';
  static const register = '/register';
  static const emailVarification = '/email-varification';
  static const login = '/login';
  static const profile = '/profile';
  static const home = '/home';
  static const tasks = '/tasks';

  // Dynamic route generator for single task
  // static String singleTask(String id) => '/task/$id';
}

class AppPages {
  static const initial = Routes.home;

  static final routes = [
    GetPage(
      name: Routes.splash,
      page: () => const SplashScreen(),
    ),

    GetPage(
      name: Routes.register,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),

    GetPage(
      name: Routes.login,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),

    GetPage(
      name: Routes.home,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),


    GetPage(
      name: Routes.tasks,
      page: () =>  ITWayBDTaskView(),
      binding: ITWayBDTaskBinding(),
    ),
 
  ];
}
