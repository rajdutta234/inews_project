import 'package:get/get.dart';
import '../controllers/news_controller.dart';
import '../controllers/auth_controller.dart';

class NewsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewsController>(() => NewsController());
    // Auth controller already put in main, ensure it exists
    if (!Get.isRegistered<AuthController>(tag: 'auth')) {
      Get.put<AuthController>(AuthController(), tag: 'auth');
    }
  }
} 