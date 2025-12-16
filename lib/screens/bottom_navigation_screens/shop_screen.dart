import 'package:flutter/material.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Shop')),
      body: Center(
        child: Text(
          'Shop Screen',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}
