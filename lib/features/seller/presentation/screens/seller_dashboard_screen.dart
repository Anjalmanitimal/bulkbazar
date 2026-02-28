import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../product/presentation/providers/product_provider.dart';
import '../../../product/presentation/screens/add_product_screen.dart';
import '../widgets/seller_product_card.dart';
import 'edit_product_screen.dart';

class SellerDashboardScreen extends ConsumerWidget {
  const SellerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.watch(productProvider);

    return Scaffold(
      backgroundColor: const Color(0xffF4F8FF),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blue,
        title: const Text(
          "My Products",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        elevation: 4,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddProductScreen()),
          );
        },
      ),

      body: productsAsync.when(
        loading: () =>
            const Center(child: CircularProgressIndicator(color: Colors.blue)),

        error: (e, _) => Center(child: Text(e.toString())),

        data: (products) {
          if (products.isEmpty) {
            return const Center(
              child: Text("No products yet", style: TextStyle(fontSize: 16)),
            );
          }

          return RefreshIndicator(
            color: Colors.blue,
            onRefresh: () async {
              await ref.read(productProvider.notifier).fetchProducts();
            },

            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: products.length,

              itemBuilder: (_, index) {
                final product = products[index];

                return SellerProductCard(
                  product: product,

                  onEdit: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EditProductScreen(product: product),
                      ),
                    );
                  },

                  onDelete: () async {
                    await ref
                        .read(productProvider.notifier)
                        .deleteProduct(product.id);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Product deleted"),
                        backgroundColor: Colors.blue,
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
