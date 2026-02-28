import 'package:bulkbazar/features/order/domain/entities/order_entity.dart';
import 'package:bulkbazar/features/order/presentation/viewmodel/order_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../view_model/cart_view_model.dart';

class BagScreen extends ConsumerWidget {
  const BagScreen({super.key});

  @override
  Widget build(context, ref) {
    final cart = ref.watch(cartViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("My Bag")),

      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,

              itemBuilder: (_, index) {
                final item = cart.items[index];

                return ListTile(
                  title: Text(item.name),

                  subtitle: Text("Rs ${item.price}"),

                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,

                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),

                        onPressed: () {
                          ref
                              .read(cartViewModelProvider.notifier)
                              .decrease(item.productId);
                        },
                      ),

                      Text(item.quantity.toString()),

                      IconButton(
                        icon: const Icon(Icons.add),

                        onPressed: () {
                          ref
                              .read(cartViewModelProvider.notifier)
                              .increase(item.productId);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16),

            child: Column(
              children: [
                Text(
                  "Total: Rs ${cart.totalAmount}",
                  style: const TextStyle(fontSize: 18),
                ),

                const SizedBox(height: 10),

                ElevatedButton(
                  onPressed: () async {
                    print("CHECKOUT CLICKED");

                    if (cart.items.isEmpty) {
                      print("Cart empty");

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Cart is empty")),
                      );

                      return;
                    }

                    try {
                      print("Creating order items...");

                      final orderItems = cart.items.map((item) {
                        return OrderItemEntity(
                          productId: item.productId,
                          quantity: item.quantity,
                          price: item.price,
                        );
                      }).toList();

                      print("Items created: ${orderItems.length}");

                      final order = OrderEntity(
                        items: orderItems,
                        totalAmount: cart.totalAmount,
                      );

                      print("Calling order API...");

                      await ref
                          .read(orderViewModelProvider.notifier)
                          .createOrder(order);

                      print("ORDER SUCCESS");

                      /// clear cart after order
                      ref.read(cartViewModelProvider.notifier).clearCart();

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Order placed successfully"),
                        ),
                      );
                    } catch (e) {
                      print("ORDER ERROR: $e");

                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text("Error: $e")));
                    }
                  },
                  child: const Text("CHECKOUT"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
