import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class QuantitySelector extends StatefulWidget {
  final int initialValue;
  final Function(int) onChanged;
  const QuantitySelector({
    super.key,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  State<QuantitySelector> createState() => _QuantitySelectorState();
}

class _QuantitySelectorState extends State<QuantitySelector> {
  late int _quantity;

  @override
  void initState() {
    super.initState();
    _quantity = widget.initialValue;
  }

  void _increment() {
    setState(() {
      _quantity++;
      widget.onChanged(_quantity);
    });
  }

  void _decrement() {
    setState(() {
      if (_quantity > 1) {
        _quantity--;
        widget.onChanged(_quantity);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 1),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: _decrement,
            child: const Icon(
              Symbols.remove_rounded,
              size: 20,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 3),
          Text(
            '$_quantity',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 3),
          GestureDetector(
            onTap: _increment,
            child: const Icon(
              Symbols.add_rounded,
              size: 20,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
