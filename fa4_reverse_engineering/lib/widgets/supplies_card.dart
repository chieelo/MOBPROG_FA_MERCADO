import 'package:fa4_reverse_engineering/models/supplies.dart';
import 'package:fa4_reverse_engineering/models/supply_class.dart';
import 'package:fa4_reverse_engineering/widgets/color_wheel.dart';
import 'package:flutter/material.dart';

class SupplyCard extends StatelessWidget {
  final Supply supply;
  final SupplyClass? supplyClass;

  const SupplyCard({
    super.key,
    required this.supply,
    required this.supplyClass,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Card(
      color: isDarkMode ? const Color.fromRGBO(93, 63, 59, 1) : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              supply.name,
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 7),
            Row(
              children: [
                Expanded(
                  child: Text(
                    supply.computedPrice,
                    style: textTheme.titleSmall,
                  ),
                ),
                if (supplyClass != null) ...[
                  ColorWheel(
                    color: supplyClass!.color,
                    size: 30,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    supplyClass!.name,
                    style: textTheme.titleSmall,
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}