import 'package:flutter/material.dart';
import 'product_card.dart';

class HorizontalProductList extends StatelessWidget {
  final bool isNew;

  const HorizontalProductList({super.key, required this.isNew});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(16),
        itemCount: 5,
        itemBuilder: (context, index) {
          return ProductCard(isNew: isNew);
        },
      ),
    );
  }
}
