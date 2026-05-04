import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class LoginFormWidget extends StatefulWidget {
  const LoginFormWidget({Key? key}) : super(key: key);

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  bool _obscurePassword = true;
  bool _rememberMe = false;
  late AuthController _authController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: 'demo@inews.com');
    _passwordController = TextEditingController();
    _authController = Get.find<AuthController>(tag: 'auth');
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            const SizedBox(height: 24),
            Text(
              'Welcome to INEWS',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Your Intelligent News Companion',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),

            // Email Field
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'Enter your email',
                prefixIcon: const Icon(Icons.email_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Colors.deepPurple,
                    width: 2,
                  ),
                ),
              ),
              keyboardType: TextInputType.emailAddress,
              enabled: !_authController.isLoading.value,
            ),
            const SizedBox(height: 16),

            // Password Field
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Enter your password',
                prefixIcon: const Icon(Icons.lock_outlined),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Colors.deepPurple,
                    width: 2,
                  ),
                ),
              ),
              obscureText: _obscurePassword,
              enabled: !_authController.isLoading.value,
            ),
            const SizedBox(height: 12),

            // Remember Me & Forgot Password
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: _rememberMe,
                      onChanged: (value) {
                        setState(() {
                          _rememberMe = value ?? false;
                        });
                      },
                      activeColor: Colors.deepPurple,
                    ),
                    const Text('Remember me'),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Please contact support to reset your password'),
                        backgroundColor: Colors.orange[700],
                        duration: const Duration(seconds: 3),
                      ),
                    );
                  },
                  child: const Text('Forgot password?'),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Error Message
            Obx(() {
              if (_authController.errorMessage.isNotEmpty) {
                return Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red[100],
                    border: Border.all(color: Colors.red[300]!),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    _authController.errorMessage.value,
                    style: TextStyle(
                      color: Colors.red[900],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            }),
            const SizedBox(height: 16),

            // Login Button
            Obx(() {
              return ElevatedButton(
                onPressed: _authController.isLoading.value
                    ? null
                    : () => _handleLogin(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  disabledBackgroundColor: Colors.grey[400],
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _authController.isLoading.value
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const Text(
                        'Sign In',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
              );
            }),
            const SizedBox(height: 24),

            // Demo Account Info
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                border: Border.all(color: Colors.blue[200]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.info_outline, color: Colors.blue[700]),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Demo Account Credentials:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[900],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  _buildDemoAccountRow('Email:', 'demo@inews.com'),
                  const SizedBox(height: 4),
                  _buildDemoAccountRow('Password:', 'Demo@123'),
                  const SizedBox(height: 8),
                  Text(
                    'Or use any of the test accounts above',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.blue[700],
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Test Accounts List
            Text(
              'Available Test Accounts:',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            ..._buildTestAccountsList(),
          ],
        ),
      ),
    );
  }

  Widget _buildDemoAccountRow(String label, String value) {
    return Row(
      children: [
        SizedBox(
          width: 80,
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.blue[900],
            ),
          ),
        ),
        Expanded(
          child: SelectableText(
            value,
            style: TextStyle(
              fontFamily: 'monospace',
              color: Colors.blue[900],
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildTestAccountsList() {
    final accounts = _authController.getDemoAccounts();
    return accounts
        .map((email) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.green[600], size: 18),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      email,
                      style: const TextStyle(fontSize: 12),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _emailController.text = email;
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Email filled, enter password'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                    ),
                    child: const Text(
                      'Use',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          );
        })
        .toList();
  }

  Future<void> _handleLogin() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please enter both email and password'),
          backgroundColor: Colors.red[700],
        ),
      );
      return;
    }

    final success = await _authController.login(
      email: email,
      password: password,
    );

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Welcome ${_authController.userName}!'),
          backgroundColor: Colors.green[700],
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }
}
