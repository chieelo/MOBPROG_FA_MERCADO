import 'package:fa4_reverse_engineering/models/supply_class.dart';
import 'package:fa4_reverse_engineering/widgets/color_wheel.dart';
import 'package:flutter/material.dart';

class ClassTile extends StatelessWidget {
  final SupplyClass supplyClass;
  const ClassTile({super.key, required this.supplyClass});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ColorWheel(color: supplyClass.color),
      title: Text(supplyClass.name),
      trailing: Text(
        supplyClass.parameterClass,
        style: Theme.of(context)
            .textTheme
            .labelSmall
            ?.copyWith(letterSpacing: 1),
      ),
    );
  }
}