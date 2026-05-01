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
      initialRoute: AppRoutes.login,
      getPages: AppPages.pages,
      initialBinding: BindingsBuilder(() {
        Get.put<AuthController>(AuthController(), tag: 'auth');
      }),
      home: _buildAuthWrapper(),
    );
  }

  ThemeMode _getThemeMode() {
    final box = GetStorage();
    final isDarkMode = box.read('isDarkMode') ?? false;
    return isDarkMode ? ThemeMode.dark : ThemeMode.light;
  }

  Widget _buildAuthWrapper() {
    return GetBuilder<AuthController>(
      init: Get.find<AuthController>(tag: 'auth'),
      builder: (authController) {
        // Show splash while checking auth
        if (authController.currentUser.value == null &&
            !authController.isLoggedIn.value) {
          // Check if user was previously logged in
          if (GetStorage().read('is_logged_in') == true) {
            return const SizedBox.shrink(); // Let auto-routing handle it
          }
          return const LoginSplashScreen();
        }
        return const SizedBox.shrink(); // Let GetX routing handle navigation
      },
    );
  }
}

class LoginSplashScreen extends StatelessWidget {
  const LoginSplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.deepPurple[700]!,
              Colors.deepPurple[500]!,
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: const Icon(
                  Icons.newspaper,
                  size: 60,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'INEWS',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Intelligent News Reader',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 48),
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
              const SizedBox(height: 24),
              const Text(
                'Loading your news...',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
