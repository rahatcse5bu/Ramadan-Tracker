import 'package:get/get.dart';

import '../../modules/dashboard/binding/dashboard_binding.dart';
import '../../modules/dashboard/view/dashboard_view.dart';
import '../../modules/dashboard/widgets/leaderboard_widget.dart';
import '../../modules/login/binding/login_binding.dart';
import '../../modules/login/view/login_view.dart';
import '../../modules/main/binding/main_view_binding.dart';
import '../../modules/main/view/main_view.dart';
import '../../modules/ramadan_planner/binding/ramadan_planner_binding.dart';
import '../../modules/ramadan_planner/view/ramadan_planner_view.dart';
import '../../modules/register/binding/register_binding.dart';
import '../../modules/register/view/register_view.dart';
import '../../splash.dart';

class Routes {
  static const splash = '/splash';
  static const home = '/home';
  static const register = '/register';
  static const emailVarification = '/email-varification';
  static const login = '/login';
  static const profile = '/profile';
  static const dashboard = '/dashboard';
  static const leaderboard = '/leaderboard';
  static const tasks = '/tasks';
  static const ramadanPlanner = '/ramadan-planner';

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
    GetPage(
      name: Routes.ramadanPlanner,
      page: () => RamadanPlannerView(),
      binding: RamadanPlannerBinding(),
    ),
    GetPage(
      name: Routes.home,
      page: () => MainView(), // Main view with nav bar
      binding: MainViewBinding(),
    ),
    GetPage(
      name: Routes.leaderboard,
      page: () => LeaderboardWidget(), // Main view with nav bar
      bindings: [RamadanPlannerBinding(),DashboardBinding() ],
    ),
  ];
}
