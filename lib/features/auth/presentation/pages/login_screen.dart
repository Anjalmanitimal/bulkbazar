import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';

import '../../../../core/api/api_client.dart';
import '../../../../core/api/api_endpoints.dart';
import '../../../../core/constants/hive_table_constants.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/blue_botton.dart';
import '../../data/models/auth_hive_model.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  bool _loading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  Future<void> _login() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    // Validation
    if (email.isEmpty || password.isEmpty) {
      _showSnackBar("All fields are required");
      return;
    }

    if (!_isValidEmail(email)) {
      _showSnackBar("Please enter a valid email address");
      return;
    }

    setState(() => _loading = true);

    try {
      final apiClient = ref.read(apiClientProvider);

      final response = await apiClient.post(
        ApiEndpoints.login,
        data: {"email": email, "password": password},
      );

      final token = response.data['token'];
      final user = response.data['data'];

      // ✅ Save JWT securely
      await _secureStorage.write(key: 'auth_token', value: token);

      // ✅ Cache user profile (NO PASSWORD)
      final box = Hive.box<AuthHiveModel>(HiveTableConstants.usersBox);
      await box.put(
        'currentUser',
        AuthHiveModel(
          name: user['fullName'],
          email: user['email'],
          role: user['role'],
          password: '',
        ),
      );

      if (!mounted) return;

      _showSnackBar("Login successful");

      // ✅ Role-based navigation
      if (user['role'] == "customer") {
        Navigator.pushReplacementNamed(context, '/dashboard');
      } else if (user['role'] == "seller") {
        Navigator.pushReplacementNamed(context, '/seller-dashboard');
      }
    } on Exception catch (e) {
      if (!mounted) return;

      // Better error handling - you can customize based on error types
      final errorMessage = e.toString().contains('DioException')
          ? "Network error. Please check your connection."
          : "Invalid email or password";

      _showSnackBar(errorMessage);
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 240, 240),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back, size: 26),
              ),

              const SizedBox(height: 10),

              const Text(
                "Login",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 30),

              CustomTextField(
                key: const Key('login_email'),
                hint: "Email",
                controller: _emailController,
              ),
              const SizedBox(height: 15),

              CustomTextField(
                key: const Key('login_password'),
                hint: "Password",
                obscure: true,
                controller: _passwordController,
              ),

              const SizedBox(height: 30),

              BlueButton(
                key: const Key('login_button'),
                text: _loading ? "LOADING..." : "LOGIN",
                onPressed: _loading ? () {} : _login,
              ),

              if (_loading)
                const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Center(child: CircularProgressIndicator()),
                ),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account? "),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/signup'),
                    child: const Icon(Icons.arrow_right_alt, size: 30),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
