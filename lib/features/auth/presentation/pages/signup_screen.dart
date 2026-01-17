import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../../../../core/api/api_client.dart';
import '../../../../core/api/api_endpoints.dart';
import '../../../../core/constants/hive_table_constants.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/blue_botton.dart';
import '../../data/models/auth_hive_model.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _loading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signup(String role) async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("All fields are required")));
      return;
    }

    setState(() => _loading = true);

    try {
      final apiClient = ref.read(apiClientProvider);

      final response = await apiClient.post(
        ApiEndpoints.register,
        data: {
          "fullName": name,
          "email": email,
          "password": password,
          "role": role,
        },
      );

      final userData = response.data['data'];

      // ✅ Save only NON-SENSITIVE data locally
      final box = Hive.box<AuthHiveModel>(HiveTableConstants.usersBox);
      await box.put(
        'currentUser',
        AuthHiveModel(
          name: userData['fullName'],
          email: userData['email'],
          role: userData['role'],
          password: '', // NEVER store password
        ),
      );

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Signup successful")));

      Navigator.pushReplacementNamed(context, '/login');
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Signup failed: ${e.toString()}")));
    } finally {
      setState(() => _loading = false);
    }
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
                "Sign up",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 30),

              CustomTextField(hint: "Full Name", controller: _nameController),
              const SizedBox(height: 15),

              CustomTextField(hint: "Email", controller: _emailController),
              const SizedBox(height: 15),

              CustomTextField(
                hint: "Password",
                obscure: true,
                controller: _passwordController,
              ),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account? "),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/login'),
                    child: const Icon(Icons.arrow_right_alt, size: 30),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              _loading
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                      children: [
                        BlueButton(
                          text: "SIGN UP AS SELLER",
                          onPressed: () => _signup("seller"),
                        ),
                        const SizedBox(height: 15),
                        BlueButton(
                          text: "SIGN UP AS CUSTOMER",
                          onPressed: () => _signup("customer"),
                        ),
                      ],
                    ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
