import 'package:fa4_reverse_engineering/widgets/app_text_field.dart';
import 'package:flutter/material.dart';


class PasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String? Function(String?)? validator;

  const PasswordField({
    super.key,
    required this.controller,
    this.validator,
    this.label = 'Password',
  });

  @override
  _PasswordFieldState createState() => _PasswordFieldState();

}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: widget.controller,
      label: widget.label,
      validator: widget.validator,
      obscureText: _obscureText,
      suffixIcon: IconButton(
        icon: Icon(
          _obscureText ? Icons.visibility : Icons.visibility_off,
        ),
        onPressed: _toggleVisibility,
      ),
    );
  }
}