import 'package:fa4_reverse_engineering/data/supply.dart';
import 'package:fa4_reverse_engineering/screens/add_class_screen.dart';
import 'package:fa4_reverse_engineering/widgets/list_tile.dart';
import 'package:flutter/material.dart';

class ParameterSettingsScreen extends StatefulWidget {
  const ParameterSettingsScreen({super.key});

  @override
  State<ParameterSettingsScreen> createState() =>
      _ParameterSettingsScreenState();
}

class _ParameterSettingsScreenState extends State<ParameterSettingsScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _openAdd() async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const AddClassScreen()),
    );
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final results = SupplyClassData.search(_searchController.text);

    return Scaffold(
      appBar: AppBar(
        title: Text('Parameter Settings', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(icon: const Icon(Icons.add), onPressed: _openAdd),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: _searchController,
              onChanged: (_) => setState(() {}),
              decoration: const InputDecoration(
                labelText: 'Search by Class',
                border: UnderlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: results.length,
              itemBuilder: (_, i) => ClassTile(supplyClass: results[i]),
            ),
          ),
        ],
      ),
    );
  }
}