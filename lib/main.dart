import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'themes/app_theme.dart';
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';
import 'controllers/auth_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'INEWS',
      theme: AppTheme.getTheme(),
      darkTheme: ThemeData.dark(),
      themeMode: _getThemeMode(),
      initialRoute: _getInitialRoute(),
      getPages: AppPages.pages,
      initialBinding: BindingsBuilder(() {
        Get.put<AuthController>(AuthController(), tag: 'auth');
      }),
    );
  }

  ThemeMode _getThemeMode() {
    final box = GetStorage();
    final isDarkMode = box.read('isDarkMode') ?? false;
    return isDarkMode ? ThemeMode.dark : ThemeMode.light;
  }

  /// Determine initial route based on authentication status
  static String _getInitialRoute() {
    final box = GetStorage();
    final isLoggedIn = box.read('is_logged_in') ?? false;
    return isLoggedIn ? AppRoutes.home : AppRoutes.login;
  }
}
