import 'package:get/get.dart';

import '../../modules/dashboard/binding/dashboard_binding.dart';
import '../../modules/dashboard/view/dashboard_view.dart';
import '../../modules/login/binding/login_binding.dart';
import '../../modules/login/view/login_view.dart';
import '../../modules/register/binding/register_binding.dart';
import '../../modules/register/view/register_view.dart';
import '../../splash.dart';

class Routes {
  static const splash = '/splash';
  static const register = '/register';
  static const emailVarification = '/email-varification';
  static const login = '/login';
  static const profile = '/profile';
  static const dashboard = '/dashboard';
  static const tasks = '/tasks';

  // Dynamic route generator for single task
  // static String singleTask(String id) => '/task/$id';
}

class AppPages {
  static const initial = Routes.splash;

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
        name: Routes.dashboard,
        page: () => DashboardView(),
        binding: DashboardBinding()),
   
  ];
}
