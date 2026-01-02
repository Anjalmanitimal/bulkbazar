import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/blue_botton.dart';
import '../../../../core/constants/hive_table_constants.dart';
import '../../data/models/user_hive_model.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signup(String role) async {
    final String name = _nameController.text.trim();
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();

    // Validation
    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("All fields are required")));
      return;
    }

    final box = Hive.box<UserHiveModel>(HiveTableConstants.usersBox);

    // Check if user already exists
    final bool userExists = box.values.any((user) => user.email == email);

    if (userExists) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("User already exists")));
      return;
    }

    // Create user
    final user = UserHiveModel(
      name: name,
      email: email,
      password: password,
      role: role,
    );

    await box.add(user);

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Signup successful")));

    // Role-based navigation
    if (role == "customer") {
      Navigator.pushReplacementNamed(context, '/login');
    } else {
      // Seller dashboard not created yet
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Seller dashboard coming soon")),
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
                "Sign up",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 30),

              CustomTextField(hint: "Name", controller: _nameController),
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

              BlueButton(
                text: "SIGN UP AS SELLER",
                onPressed: () => _signup("seller"),
              ),

              const SizedBox(height: 15),

              BlueButton(
                text: "SIGN UP AS CUSTOMER",
                onPressed: () => _signup("customer"),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
