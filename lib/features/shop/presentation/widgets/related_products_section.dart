import 'package:flutter/material.dart';
import '../../../product/domain/entities/product_entity.dart';
import '../screens/product_detail_screen.dart';

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
            height: 180,

            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: products.length,

              itemBuilder: (_, index) {
                final product = products[index];

                final imageUrl = "http://10.0.2.2:4000${product.image}";

                final price = product.pricing.isNotEmpty
                    ? product.pricing.first.price
                    : 0;

                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProductDetailScreen(product: product),
                      ),
                    );
                  },

                  child: Container(
                    width: 140,
                    margin: const EdgeInsets.only(right: 12),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),

                          child: Image.network(
                            imageUrl,
                            height: 100,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),

                        const SizedBox(height: 6),

                        Text(
                          product.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),

                        Text(
                          "Rs. $price",
                          style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
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
