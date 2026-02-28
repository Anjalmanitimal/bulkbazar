import 'package:flutter/material.dart';

class CategoryChip extends StatelessWidget {
  final String name;
  final bool selected;
  final VoidCallback onTap;

  const CategoryChip({
    super.key,
    required this.name,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? Colors.blue : Colors.white,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Colors.blue),
          boxShadow: [
            if (selected)
              BoxShadow(color: Colors.blue.withOpacity(0.3), blurRadius: 8),
          ],
        ),
        child: Text(
          name,
          style: TextStyle(
            color: selected ? Colors.white : Colors.blue,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
