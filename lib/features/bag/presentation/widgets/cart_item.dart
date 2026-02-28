import 'package:flutter/material.dart';
import '../../domain/entities/cart_entity.dart';

class CartItem extends StatelessWidget {
  final CartEntity cart;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;

  const CartItem({
    super.key,
    required this.cart,
    required this.onIncrease,
    required this.onDecrease,
  });

  @override
  Widget build(BuildContext context) {
    final price = cart.product.pricing.first.price;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),

      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          Expanded(
            child: Text(
              cart.product.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),

          Row(
            children: [
              IconButton(onPressed: onDecrease, icon: const Icon(Icons.remove)),

              Text("${cart.quantity}"),

              IconButton(onPressed: onIncrease, icon: const Icon(Icons.add)),
            ],
          ),

          Text("Rs ${(price * cart.quantity).toInt()}"),
        ],
      ),
    );
  }
}
