
import 'package:fa4_reverse_engineering/data/supply.dart';
import 'package:fa4_reverse_engineering/screens/add_supplies_screen.dart';
import 'package:fa4_reverse_engineering/widgets/supplies_card.dart';
import 'package:fa4_reverse_engineering/widgets/supply_chart.dart';
import 'package:flutter/material.dart';

class SuppliesScreen extends StatefulWidget {
  const SuppliesScreen({super.key});

  @override
  State<SuppliesScreen> createState() => _SuppliesScreenState();
}

class _SuppliesScreenState extends State<SuppliesScreen> {
  late List<dynamic> _currentSupplies;

  @override
  void initState() {
    super.initState();

    _currentSupplies = List<dynamic>.from(SupplyData.supplies);
  }

  Future<void> _openAdd() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const AddSupplyScreen(),
      ),
    );

    if (!mounted) return;

    setState(() {
      _currentSupplies = List.from(SupplyData.supplies);
    });
  }

  @override
  Widget build(BuildContext context) {
    final chartClasses = SupplyClassData.classes
    .where((c) => c.parameterClass == 'BASE_WEAPON')
    .toList();

    final allTotals = SupplyData.totalsByClass();

    final totals = {
      for (final c in chartClasses)
        c.id: allTotals[c.id] ?? 0.0,
    };

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Supply Manager',
          style: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _openAdd,
          ),
        ],
      ),

      body: Column(
        children: [
          if (SupplyData.supplies.isNotEmpty)
            SupplyChart(
              classes: chartClasses,
              totals: totals,
            ),

          Expanded(
            child: _currentSupplies.isEmpty
                ? const SizedBox.shrink()
                : ListView.builder(
                    itemCount: _currentSupplies.length,
                    itemBuilder: (_, i) {
                      final supply = _currentSupplies[i];

                      return Dismissible(
                        key: ValueKey(supply.id),
                        direction: DismissDirection.horizontal,
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 20),
                        ),
                        secondaryBackground: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20),
                        ),
                        onDismissed: (direction) {
                          setState(() {
                            _currentSupplies.removeWhere(
                              (item) => item.id == supply.id,
                            );
                          });
                        },
                        child: SupplyCard(
                          supply: supply,
                          supplyClass: SupplyClassData.byId(
                            supply.parameterClassId,
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
