import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../product/presentation/providers/product_provider.dart';
import '../../../product/presentation/screens/add_product_screen.dart';
import '../widgets/seller_product_card.dart';

class SellerDashboardScreen extends ConsumerWidget {
  const SellerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.watch(productProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("My Products")),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddProductScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),

      body: productsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),

        error: (e, _) => Center(child: Text(e.toString())),

        data: (products) {
          if (products.isEmpty) {
            return const Center(child: Text("No products yet"));
          }

          return RefreshIndicator(
            onRefresh: () async {
              ref.refresh(productProvider);
            },

            child: ListView.builder(
              padding: const EdgeInsets.all(16),

              itemCount: products.length,

              itemBuilder: (_, index) {
                final product = products[index];

                return SellerProductCard(
                  product: product,

                  onEdit: () {
                    /// Next step: open edit screen
                  },

                  onDelete: () {
                    /// Next step: delete product
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
