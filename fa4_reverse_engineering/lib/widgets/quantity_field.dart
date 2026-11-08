
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class QuantityField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final int min;
  final int max;

  const QuantityField({
    super.key,
    required this.controller,
    this.label = 'Item Quantity',
    this.min = 1,
    this.max = 100,
  });

  void _change(int delta) {
    final current = int.tryParse(controller.text.trim()) ?? min;

    controller.text = (current + delta).clamp(min, max).toString();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.titleSmall,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        TextInputFormatter.withFunction((oldValue, newValue) {
          if (newValue.text.isEmpty) return newValue;

          final value = int.tryParse(newValue.text);

          if (value == null || value < min || value > max) {
            return oldValue;
          }

          return newValue;
        }),
      ],
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        prefixIcon: IconButton(
          icon: const Icon(Icons.remove),
          onPressed: () => _change(-1),
        ),
        suffixIcon: IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => _change(1),
        ),
      ),
    );
  }
}
