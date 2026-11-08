
import 'package:fa4_reverse_engineering/data/supply.dart';
import 'package:fa4_reverse_engineering/models/supplies.dart';
import 'package:fa4_reverse_engineering/widgets/app_text_field.dart';
import 'package:fa4_reverse_engineering/widgets/color_wheel.dart';
import 'package:fa4_reverse_engineering/widgets/quantity_field.dart';
import 'package:flutter/material.dart';

class AddSupplyScreen extends StatefulWidget {
  const AddSupplyScreen({super.key});

  @override
  State<AddSupplyScreen> createState() => _AddSupplyScreenState();
}

class _AddSupplyScreenState extends State<AddSupplyScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _quantityController = TextEditingController(text: '1');
  final _priceController = TextEditingController(text: '1.00');

  String? _classId = SupplyClassData.classes
      .where((c) => c.parameterClass == 'BASE_WEAPON')
      .firstOrNull
      ?.id;

  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _quantityController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_isLoading) return;

    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    final quantity = int.tryParse(_quantityController.text.trim());

    final String price =
        double.tryParse(_priceController.text.trim())
            ?.toStringAsFixed(2) ??
        '';

    if (quantity == null || quantity < 1 || price == '') return;

    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;

    SupplyData.add(
      Supply(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        name: _nameController.text.trim(),
        quantity: quantity,
        unitPrice: price,
        parameterClassId: _classId!,
      ),
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final categories = SupplyClassData.classes;

    final weaponCategories = categories
        .where((c) => c.parameterClass == 'BASE_WEAPON')
        .toList();

    if (_classId != null &&
        !weaponCategories.any((c) => c.id == _classId)) {
      _classId = null;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add a new supply',
          style: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 80),

          child: Form(
            key: _formKey,

            child: Column(
              children: [
                const SizedBox(height: 80),

                AppTextField(
                  label: 'Item Name',
                  controller: _nameController,
                  validator: (v) =>
                      (v == null || v.trim().isEmpty)
                          ? 'Kindly enter the item name'
                          : null,
                ),

                const SizedBox(height: 30),

                QuantityField(
                  controller: _quantityController,
                ),

                const SizedBox(height: 30),

                AppTextField(
                  label: 'Unit Price',
                  prefixText: '\$',
                  controller: _priceController,
                  validator: (v) =>
                      (v == null || v.trim().isEmpty)
                          ? 'Kindly enter the unit price'
                          : null,
                ),

                const SizedBox(height: 30),

                DropdownButtonFormField<String>(
                  value: _classId,

                  decoration: InputDecoration(
                    labelText: 'Supply Category',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: BorderSide(
                        color: Theme.of(context).brightness ==
                                Brightness.dark
                            ? Colors.white70
                            : Colors.black,
                        width: 0.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 1.5,
                      ),
                    ),
                  ),

                  items: [
                    for (final c in weaponCategories)
                      DropdownMenuItem(
                        value: c.id,
                        child: Row(
                          children: [
                            ColorWheel(color: c.color),

                            const SizedBox(width: 12),

                            Text(
                              c.name.toUpperCase(),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall,
                            ),
                          ],
                        ),
                      ),
                  ],

                  onChanged: (v) {
                    setState(() {
                      _classId = v;
                    });
                  },

                  validator: (v) =>
                      v == null ? 'Kindly select a category' : null,
                ),

                const SizedBox(height: 30),

                ElevatedButton(
                  onPressed: _isLoading ? null : _save,
                  child: _isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        )
                      : const Text('Save'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
