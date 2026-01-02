import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/blue_botton.dart';
import '../../../../core/constants/hive_table_constants.dart';
import '../../data/models/user_hive_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("All fields are required")));
      return;
    }

    final box = Hive.box<UserHiveModel>(HiveTableConstants.usersBox);

    try {
      final user = box.values.firstWhere(
        (u) => u.email == email && u.password == password,
      );

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Login successful")));

      // Role-based navigation
      if (user.role == "customer") {
        Navigator.pushReplacementNamed(context, '/dashboard');
      } else if (user.role == "seller") {
        // Seller dashboard not implemented yet
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Seller dashboard coming soon")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Invalid email or password")),
      );
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
                "Login",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 30),

              CustomTextField(hint: "Email", controller: _emailController),
              const SizedBox(height: 15),

              CustomTextField(
                hint: "Password",
                obscure: true,
                controller: _passwordController,
              ),

              const SizedBox(height: 30),

              BlueButton(text: "LOGIN", onPressed: _login),

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
