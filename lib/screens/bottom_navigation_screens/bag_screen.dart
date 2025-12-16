import 'package:flutter/material.dart';

class BagScreen extends StatelessWidget {
  const BagScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Bag')),
      body: Center(
        child: Text(
          'Bag Screen',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}
