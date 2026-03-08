import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../view_model/cart_view_model.dart';
import '../../../order/domain/entities/order_entity.dart';
import '../../../order/presentation/viewmodel/order_viewmodel.dart';

/// SENSOR IMPORTS
import '../../../../core/utils/accelerometer_service.dart';
import '../../../../core/utils/proximity_service.dart';
import '../../../../core/api/api_endpoints.dart';

class BagScreen extends ConsumerStatefulWidget {
  const BagScreen({super.key});

  @override
  ConsumerState<BagScreen> createState() => _BagScreenState();
}

class _BagScreenState extends ConsumerState<BagScreen> {
  final AccelerometerService _accelerometerService = AccelerometerService();
  final ProximityService _proximityService = ProximityService();

  bool hidePrices = false;

  @override
  void initState() {
    super.initState();

    /// SHAKE PHONE → CLEAR BAG
    _accelerometerService.startListening(() {
      final cart = ref.read(cartViewModelProvider);

      /// DO NOTHING IF CART EMPTY
      if (cart.items.isEmpty) return;

      ref.read(cartViewModelProvider.notifier).clearCart();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Bag cleared by shaking phone")),
      );
    });

    /// COVER PHONE → HIDE PRICES
    _proximityService.startListening((near) {
      setState(() {
        hidePrices = near;
      });
    });
  }

  @override
  void dispose() {
    _accelerometerService.stopListening();
    _proximityService.stopListening();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cart = ref.watch(cartViewModelProvider);
    final orderState = ref.watch(orderViewModelProvider);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        title: const Text(
          "My Bag",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),

      body: cart.items.isEmpty
          ? const Center(
              child: Text("Your bag is empty", style: TextStyle(fontSize: 16)),
            )
          : Column(
              children: [
                /// CART LIST
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: cart.items.length,
                    itemBuilder: (context, index) {
                      final item = cart.items[index];

                      return Container(
                        margin: const EdgeInsets.only(bottom: 14),
                        padding: const EdgeInsets.all(12),

                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 8,
                              color: Colors.black.withOpacity(0.05),
                            ),
                          ],
                        ),

                        child: Row(
                          children: [
                            /// IMAGE
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                "${ApiEndpoints.imageBaseUrl}${item.image}",
                                width: 70,
                                height: 70,
                                fit: BoxFit.cover,
                              ),
                            ),

                            const SizedBox(width: 12),

                            /// INFO
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  /// NAME
                                  Text(
                                    item.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),

                                  const SizedBox(height: 6),

                                  /// PRICE
                                  Text(
                                    hidePrices ? "Rs ***" : "Rs ${item.price}",
                                    style: const TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  const SizedBox(height: 10),

                                  /// QTY + DELETE
                                  Row(
                                    children: [
                                      /// DECREASE
                                      _qtyButton(
                                        icon: Icons.remove,
                                        onTap: () {
                                          ref
                                              .read(
                                                cartViewModelProvider.notifier,
                                              )
                                              .decrease(item.productId);
                                        },
                                      ),

                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                        ),
                                        child: Text(
                                          item.quantity.toString(),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),

                                      /// INCREASE
                                      _qtyButton(
                                        icon: Icons.add,
                                        onTap: () {
                                          ref
                                              .read(
                                                cartViewModelProvider.notifier,
                                              )
                                              .increase(item.productId);
                                        },
                                      ),

                                      const Spacer(),

                                      /// DELETE
                                      GestureDetector(
                                        onTap: () {
                                          ref
                                              .read(
                                                cartViewModelProvider.notifier,
                                              )
                                              .remove(item.productId);
                                        },
                                        child: const Icon(
                                          Icons.delete_outline,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                /// TOTAL + CHECKOUT
                Container(
                  padding: const EdgeInsets.all(16),

                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),

                  child: Column(
                    children: [
                      /// TOTAL
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Total", style: TextStyle(fontSize: 18)),

                          Text(
                            hidePrices
                                ? "Rs ***"
                                : "Rs ${cart.totalAmount.toStringAsFixed(2)}",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      /// CHECKOUT
                      SizedBox(
                        width: double.infinity,
                        height: 55,

                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),

                          onPressed: orderState.loading
                              ? null
                              : () async {
                                  final order = OrderEntity(
                                    id: "",
                                    createdAt: DateTime.now(),

                                    items: cart.items.map((e) {
                                      return OrderItemEntity(
                                        productId: e.productId,
                                        productName: e.name,
                                        image: e.image,
                                        quantity: e.quantity,
                                        price: e.price,
                                      );
                                    }).toList(),

                                    totalAmount: cart.totalAmount,
                                  );

                                  await ref
                                      .read(orderViewModelProvider.notifier)
                                      .createOrder(order);

                                  ref
                                      .read(cartViewModelProvider.notifier)
                                      .clearCart();

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        "Order placed successfully",
                                      ),
                                    ),
                                  );
                                },

                          child: orderState.loading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text(
                                  "CHECKOUT",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Widget _qtyButton({required IconData icon, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),

      child: Container(
        padding: const EdgeInsets.all(6),

        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(8),
        ),

        child: Icon(icon, size: 18, color: Colors.blue),
      ),
    );
  }
}
