import 'package:flutter/material.dart';
import '../../../product/domain/entities/product_entity.dart';

class SellerProductCard extends StatelessWidget {
  final ProductEntity product;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const SellerProductCard({
    super.key,
    required this.product,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final imageUrl = "http://10.0.2.2:5000/${product.image}";

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Product Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
            child: Image.network(
              imageUrl,
              height: 170,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Name + actions
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        product.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    PopupMenuButton(
                      itemBuilder: (_) => [
                        PopupMenuItem(value: "edit", child: const Text("Edit")),
                        PopupMenuItem(
                          value: "delete",
                          child: const Text("Delete"),
                        ),
                      ],
                      onSelected: (value) {
                        if (value == "edit") onEdit();
                        if (value == "delete") onDelete();
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 6),

                Text(
                  product.description,
                  style: TextStyle(color: Colors.grey[600]),
                ),

                const SizedBox(height: 10),

                const Text(
                  "MOQ Pricing",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 6),

                ...product.pricing.map(
                  (price) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Min ${price.moq} pcs"),
                      Text(
                        "Rs. ${price.price}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
