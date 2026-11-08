import 'package:fa4_reverse_engineering/models/supply_class.dart';
import 'package:flutter/material.dart';

class SupplyChart extends StatelessWidget {
  final List<SupplyClass> classes;
  final Map<String, double> totals;

  const SupplyChart({
    super.key,
    required this.classes,
    required this.totals,
  });

  static const double _chartHeight = 200;
  static const double _stripHeight = 30;

  double _fill(double total, double maxTotal) {
    if (maxTotal == 0) return 0;
    return total / maxTotal;
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    final maxTotal = totals.values.fold<double>(
      0,
      (max, value) => value > max ? value : max,
    );

    final barColor = Color.alphaBlend(
      scheme.primary.withValues(alpha: 0.6),
      scheme.surface,
    );

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 20),
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 8,
      ),
      width: double.infinity,
      height: _chartHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            scheme.primary.withValues(alpha: 0),
            scheme.primary.withValues(alpha: 0.25),
          ],
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (final c in classes)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                      ),
                      child: TweenAnimationBuilder<double>(
                        tween: Tween<double>(
                          end: _fill(
                            totals[c.id] ?? 0,
                            maxTotal,
                          ),
                        ),
                        duration: const Duration(milliseconds: 600),
                        curve: Curves.easeOut,
                        builder: (context, fill, child) {
                          return FractionallySizedBox(
                            heightFactor: fill,
                            alignment: Alignment.bottomCenter,
                            child: child,
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: barColor,
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              for (final c in classes)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                    ),
                    child: Container(
                      height: _stripHeight,
                      decoration: BoxDecoration(
                        color: c.color,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
