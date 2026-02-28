import 'package:flutter/material.dart';
import '../../../product/domain/entities/product_entity.dart';

class ProductDetailHeader extends StatelessWidget {
  final ProductEntity product;

  const ProductDetailHeader({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final imageUrl = "http://10.0.2.2:4000${product.image}";

    return Container(
      height: 280,
      width: double.infinity,
      color: Colors.grey.shade100,
      child: Image.network(imageUrl, fit: BoxFit.contain),
    );
  }
}
