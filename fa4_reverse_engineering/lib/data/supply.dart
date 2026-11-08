import 'package:fa4_reverse_engineering/models/supplies.dart';
import 'package:fa4_reverse_engineering/models/supply_class.dart';
import 'package:flutter/material.dart';
class SupplyClassData {
  static const String supplyCategory = 'BASE_WEAPON';

  static final List<SupplyClass> classes = [
    const SupplyClass(
      id: '1',
      name: 'Toy',
      parameterClass: 'GAME',
      color: Color(0xFFFF4040),
    ),
    const SupplyClass(
      id: '2',
      name: 'Medical Kit',
      parameterClass: 'BASE_PARAM',
      color: Color(0xFF1A00FF),
    ),
    const SupplyClass(
      id: '4',
      name: 'Melee',
      parameterClass: 'BASE_WEAPON',
      color: Color(0xFFFF2EFF),
    ),
    const SupplyClass(
      id: '5',
      name: 'Collectible',
      parameterClass: 'BASE_TOYS',
      color: Color(0xFF00FFFF),
    ),
    const SupplyClass(
      id: '6',
      name: 'Assault Rifle',
      parameterClass: 'BASE_WEAPON',
      color: Color(0xFF9CFF4D),
    ),
  ];

  static SupplyClass? byId(String id) {
    for (final c in classes) {
      if (c.id == id) return c;
    }
    return null;
  }

  static List<SupplyClass> get supplyCategories =>
      classes.where((c) => c.parameterClass == supplyCategory).toList();

  static List<SupplyClass> search(String query) {
    final q = query.trim().toLowerCase();

    if (q.isEmpty) return classes;

    return classes
        .where((c) => c.parameterClass.toLowerCase().contains(q))
        .toList();
  }

  static void add(SupplyClass c) => classes.add(c);
}

class SupplyData {
  SupplyData._();

  static final List<Supply> supplies = [
    Supply(
      id: '1',
      name: 'Toy Car',
      quantity: 25,
      unitPrice: '80',
      parameterClassId: '6',
    ),
    Supply(
      id: '2',
      name: 'First Aid Kit',
      quantity: 4,
      unitPrice: '3',
      parameterClassId: '6',
    ),
    Supply(
      id: '3',
      name: 'Combat Knife',
      quantity: 10,
      unitPrice: '50',
      parameterClassId: '4',
    ),
    Supply(
      id: '4',
      name: 'Assault Rifle',
      quantity: 5,
      unitPrice: '100',
      parameterClassId: '6',
    ),
    Supply(
      id: '5',
      name: 'Toy Robot',
      quantity: 8,
      unitPrice: '12',
      parameterClassId: '4',
    ),
  ];

  static void add(Supply s) => supplies.add(s);

  static Map<String, double> totalsByClass() {
    final Map<String, double> totals = {};

    for (final supply in supplies) {
      totals[supply.parameterClassId] =
          (totals[supply.parameterClassId] ?? 0) +
          supply.quantity.toDouble();
    }

    return totals;
  }
}