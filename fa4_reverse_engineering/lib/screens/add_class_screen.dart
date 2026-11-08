import 'package:fa4_reverse_engineering/data/supply.dart';
import 'package:fa4_reverse_engineering/models/supply_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class AddClassScreen extends StatefulWidget {
  const AddClassScreen({super.key});

  @override
  State<AddClassScreen> createState() => _AddClassScreenState();
}

class _AddClassScreenState extends State<AddClassScreen> {
  final _formKey = GlobalKey<FormState>();
  final _classController = TextEditingController();
  final _nameController = TextEditingController();

  Color _color = Colors.red;

  @override
  void dispose() {
    _classController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    SupplyClassData.add(
      SupplyClass(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        name: _nameController.text.trim(),
        parameterClass: _classController.text.trim().toUpperCase(),
        color: _color,
      ),
    );

    Navigator.of(context).pop();
  }

  void _reset() {
    _classController.clear();
    _nameController.clear();
    _formKey.currentState!.reset();
  }

  String? _required(String? value, String message) {
    if (value == null || value.trim().isEmpty) {
      return message;
    }

    return null;
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String errorMessage,
  }) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return TextFormField(
      controller: controller,
      maxLength: 50,
      style: TextStyle(
        fontSize: 16,
        color: colors.onSurface,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          fontSize: 16,
          color: colors.onSurface,
        ),
        counterStyle: TextStyle(
          fontSize: 14,
          color: colors.onSurface,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: colors.outline,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: colors.primary,
            width: 1.5,
          ),
        ),
        errorStyle: TextStyle(
          color: colors.primary,
          fontSize: 12,
        ),
        contentPadding: const EdgeInsets.only(bottom: 8),
      ),
      validator: (value) => _required(value, errorMessage),
    );
  }

  Widget _buildColorPicker() {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 250,
          height: 250,
          child: ColorPickerArea(
            HSVColor.fromColor(_color),
            (HSVColor color) {
              setState(() {
                _color = color.toColor();
              });
            },
            PaletteType.hueWheel,
          ),
        ),

        const SizedBox(height: 12),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: _color,
                border: Border.all(
                  color: Colors.black26,
                  width: 0.5,
                ),
              ),
            ),

            const SizedBox(width: 6),

            Text(
              '#${_color.toARGB32().toRadixString(16).toUpperCase().padLeft(8, '0')}',
              style: TextStyle(
                fontSize: 16,
                color: colors.onSurface,
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: _reset,
              style: TextButton.styleFrom(
                foregroundColor: colors.primary,
              ),
              child: const Text(
                'Reset',
                style: TextStyle(fontSize: 16),
              ),
            ),

            const SizedBox(width: 8),

            ElevatedButton(
              onPressed: _save,
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.primary,
                foregroundColor: colors.onPrimary,
                elevation: 2,
                minimumSize: const Size(178, 42),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'Add Parameter',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text(
          'Add a new parameter',
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: colors.primary,
          ),
        ),
      ),

      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 700;

            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),

              child: Form(
                key: _formKey,

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTextField(
                      label: 'Parameter Name',
                      controller: _nameController,
                      errorMessage: 'Kindly enter the parameter name',
                    ),

                    const SizedBox(height: 12),

                    if (isWide) ...[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 300),
                              child: _buildTextField(
                                label: 'Parameter Class',
                                controller: _classController,
                                errorMessage:
                                    'Kindly enter the parameter class',
                              ),
                            ),
                          ),

                          const SizedBox(width: 40),

                          Expanded(
                            flex: 1,
                            child: Center(
                              child: _buildColorPicker(),
                            ),
                          ),
                        ],
                      ),
                    ] else ...[
                      const SizedBox(height: 16),

                      _buildColorPicker(),

                      const SizedBox(height: 24),

                      _buildTextField(
                        label: 'Parameter Class',
                        controller: _classController,
                        errorMessage:
                            'Kindly enter the parameter class',
                      ),
                    ],
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
