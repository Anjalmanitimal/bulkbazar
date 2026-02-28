import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../product/domain/entities/product_entity.dart';
import '../../../bag/presentation/view_model/cart_view_model.dart';

class AddToCartButton extends ConsumerWidget {
  final ProductEntity product;

  const AddToCartButton({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16),

      child: SizedBox(
        width: double.infinity,
        height: 50,

        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),

          onPressed: () {
            ref.read(cartViewModelProvider.notifier).addToCart(product);

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("${product.name} added to bag")),
            );
          },

          child: const Text("ADD TO CART", style: TextStyle(fontSize: 16)),
        ),
      ),
    );
  }
}
