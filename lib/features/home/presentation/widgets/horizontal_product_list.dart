import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../product/presentation/providers/product_provider.dart';
import '../../../../core/api/api_endpoints.dart';

class HorizontalProductList extends ConsumerWidget {
  final bool isNew;

  const HorizontalProductList({super.key, required this.isNew});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productState = ref.watch(productProvider);

    return SizedBox(
      height: 220,
      child: productState.when(
        loading: () => const Center(child: CircularProgressIndicator()),

        error: (e, _) => Center(child: Text("Error: $e")),

        data: (products) {
          if (products.isEmpty) {
            return const Center(child: Text("No products found"));
          }

          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemBuilder: (context, index) {
              final product = products[index];

              return Container(
                width: 160,
                margin: const EdgeInsets.only(right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// IMAGE
                    Container(
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey[200],
                        image: product.image != null
                            ? DecorationImage(
                                image: NetworkImage(
                                  "${ApiEndpoints.baseUrl}/${product.image}",
                                ),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                    ),

                    const SizedBox(height: 8),

                    /// NAME
                    Text(
                      product.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),

                    const SizedBox(height: 4),

                    /// MOQ PRICE (show first tier)
                    Text(
                      product.pricing.isNotEmpty
                          ? "Rs ${product.pricing.first.price} (MOQ ${product.pricing.first.moq})"
                          : "No pricing",
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
