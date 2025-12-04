import 'package:flutter/material.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/blue_botton.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

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
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back, size: 26),
              ),

              const SizedBox(height: 10),
              const Text(
                "Sign up",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 30),
              const CustomTextField(hint: "Name"),

              const SizedBox(height: 15),
              const CustomTextField(hint: "Email"),

              const SizedBox(height: 15),
              const CustomTextField(hint: "Password", obscure: true),

              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account? "),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: Row(
                      children: const [
                        Text("", style: TextStyle(fontWeight: FontWeight.bold)),
                        Icon(Icons.arrow_right_alt, size: 30),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),
              BlueButton(text: "SIGN UP AS SELLER", onPressed: () {}),
              const SizedBox(height: 15),
              BlueButton(text: "SIGN UP AS CUSTOMER", onPressed: () {}),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
