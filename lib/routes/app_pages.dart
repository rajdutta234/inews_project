import 'package:get/get.dart';
import '../views/home_view.dart';
import '../views/detail_view.dart';
import '../views/settings_view.dart';
import '../views/login_view.dart';
import '../bindings/news_binding.dart';
import '../bindings/auth_binding.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginView(),
      binding: AuthBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => HomeView(),
      binding: NewsBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.detail,
      page: () => DetailView(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.settings,
      page: () => SettingsView(),
      transition: Transition.rightToLeft,
    ),
  ];
}
