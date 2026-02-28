import 'package:flutter/material.dart';
import '../../../product/domain/entities/product_entity.dart';

class ProductDetailHeader extends StatelessWidget {
  final ProductEntity product;

  const ProductDetailHeader({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final imageUrl = "http://10.0.2.2:4000${product.image}";

    /// FIX PRICE
    final price = product.pricing.isNotEmpty ? product.pricing.first.price : 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// IMAGE
        Container(
          height: 280,
          width: double.infinity,
          color: Colors.grey.shade100,
          child: Image.network(imageUrl, fit: BoxFit.contain),
        ),

        const SizedBox(height: 12),

        /// PRICE (ADD THIS)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "Rs. $price",
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        ),
      ],
    );
  }
}
