import 'package:get/get.dart';
import '../views/home_view.dart';
import '../views/detail_view.dart';
import '../views/settings_view.dart';
import '../bindings/news_binding.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.home,
      page: () => HomeView(),
      binding: NewsBinding(),
    ),
    GetPage(name: AppRoutes.detail, page: () => DetailView()),
    GetPage(name: AppRoutes.settings, page: () => SettingsView()),
  ];
}
