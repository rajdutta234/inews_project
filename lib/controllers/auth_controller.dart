import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../models/user_model.dart';
import '../routes/app_routes.dart';

class AuthController extends GetxController {
  static const String _storageKey = 'auth_user';
  static const String _isLoggedInKey = 'is_logged_in';

  final box = GetStorage();
  final Rx<UserModel?> currentUser = Rx<UserModel?>(null);
  final RxBool isLoggedIn = RxBool(false);
  final RxBool isLoading = RxBool(false);
  final RxString errorMessage = RxString('');

  // Demo account credentials
  static const String demoEmail = 'demo@inews.com';
  static const String demoPassword = 'Demo@123';
  static const String demoName = 'Demo User';

  // All available demo accounts (can add more for testing)
  static const Map<String, Map<String, String>> demoAccounts = {
    demoEmail: {
      'password': demoPassword,
      'name': demoName,
    },
    'user@inews.com': {
      'password': 'User@123',
      'name': 'John Doe',
    },
    'test@inews.com': {
      'password': 'Test@123',
      'name': 'Test User',
    },
  };

  @override
  void onInit() {
    super.onInit();
    _loadStoredUser();
  }

  /// Load user from local storage if exists
  void _loadStoredUser() {
    try {
      final storedUser = box.read(_storageKey);
      if (storedUser != null && storedUser is Map) {
        currentUser.value = UserModel.fromJson(Map.from(storedUser));
        isLoggedIn.value = box.read(_isLoggedInKey) ?? false;
      }
    } catch (e) {
      print('Error loading stored user: $e');
    }
  }

  /// Login with email and password
  Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      // Validate inputs
      if (email.isEmpty || password.isEmpty) {
        errorMessage.value = 'Email and password are required';
        return false;
      }

      if (!_isValidEmail(email)) {
        errorMessage.value = 'Please enter a valid email address';
        return false;
      }

      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));

      // Check if credentials match demo or test accounts
      if (demoAccounts.containsKey(email)) {
        final account = demoAccounts[email];
        if (account?['password'] == password) {
          // Create user object
          final user = UserModel(
            id: _generateUserId(),
            email: email,
            name: account?['name'] ?? 'User',
            password: password,
            createdAt: DateTime.now(),
            lastLogin: DateTime.now(),
            isActive: true,
          );

          // Save user to storage
          currentUser.value = user;
          isLoggedIn.value = true;
          await box.write(_storageKey, user.toJson());
          await box.write(_isLoggedInKey, true);

          errorMessage.value = '';
          return true;
        } else {
          errorMessage.value = 'Invalid email or password';
          return false;
        }
      } else {
        errorMessage.value = 'Account not found. Use demo account to test.';
        return false;
      }
    } catch (e) {
      errorMessage.value = 'An error occurred: $e';
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  /// Logout current user
  Future<bool> logout() async {
    try {
      isLoading.value = true;
      await Future.delayed(const Duration(milliseconds: 500));

      currentUser.value = null;
      isLoggedIn.value = false;
      await box.remove(_storageKey);
      await box.remove(_isLoggedInKey);
      errorMessage.value = '';

      Get.offAllNamed(AppRoutes.login);
      return true;
    } catch (e) {
      errorMessage.value = 'Error logging out: $e';
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  /// Update user profile
  Future<bool> updateProfile({
    required String name,
    required String email,
  }) async {
    try {
      if (currentUser.value == null) {
        errorMessage.value = 'No user logged in';
        return false;
      }

      if (name.isEmpty || email.isEmpty) {
        errorMessage.value = 'Name and email are required';
        return false;
      }

      if (!_isValidEmail(email)) {
        errorMessage.value = 'Please enter a valid email address';
        return false;
      }

      isLoading.value = true;
      await Future.delayed(const Duration(milliseconds: 500));

      // Update user
      final updatedUser = currentUser.value!.copyWith(
        name: name,
        email: email,
      );

      currentUser.value = updatedUser;
      await box.write(_storageKey, updatedUser.toJson());
      errorMessage.value = '';

      return true;
    } catch (e) {
      errorMessage.value = 'Error updating profile: $e';
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  /// Check if user is authenticated
  bool get isAuthenticated => isLoggedIn.value && currentUser.value != null;

  /// Get current user name
  String get userName => currentUser.value?.name ?? 'User';

  /// Get current user email
  String get userEmail => currentUser.value?.email ?? '';

  /// Validate email format
  bool _isValidEmail(String email) {
    final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return regex.hasMatch(email);
  }

  /// Generate unique user ID
  String _generateUserId() {
    return '${DateTime.now().millisecondsSinceEpoch}_${(DateTime.now().microsecond % 10000).toString().padLeft(4, '0')}';
  }

  /// Get all demo accounts (for help/information)
  List<String> getDemoAccounts() {
    return demoAccounts.keys.toList();
  }
}
