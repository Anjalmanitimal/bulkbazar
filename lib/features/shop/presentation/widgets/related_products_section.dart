import 'package:flutter/material.dart';
import '../../../product/domain/entities/product_entity.dart';

class RelatedProductsSection extends StatelessWidget {
  final List<ProductEntity> products;

  const RelatedProductsSection({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) return const SizedBox();

    return Padding(
      padding: const EdgeInsets.all(16),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          const Text(
            "You may also like",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 12),

          SizedBox(
            height: 160,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: products.length,

              itemBuilder: (_, index) {
                final product = products[index];

                final imageUrl = "http://10.0.2.2:4000${product.image}";

                return Container(
                  width: 130,
                  margin: const EdgeInsets.only(right: 12),

                  child: Column(
                    children: [
                      Image.network(imageUrl, height: 90),

                      Text(product.name, maxLines: 1),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
