import 'package:flutter/material.dart';
import 'package:food_delivery_app/models/food.dart';

class QuantitySelector extends StatefulWidget {
  final int quantity;
  final Food food;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const QuantitySelector({
    super.key,
    required this.quantity,
    required this.food,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  State<QuantitySelector> createState() => _QuantitySelectorState();
}

class _QuantitySelectorState extends State<QuantitySelector> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // decrement button
          IconButton(
            onPressed: widget.onDecrement,
            icon: Icon(
              Icons.remove,
              size: 16,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),

          // quantity count
          Center(
            child: Text(
              widget.quantity.toString(),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // increment button
          IconButton(
            onPressed: widget.onIncrement,
            icon: Icon(
              Icons.add,
              size: 16,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
