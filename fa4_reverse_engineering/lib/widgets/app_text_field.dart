import 'package:flutter/material.dart';


class AppTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String? Function(String?)? validator;
  final int? maxLength;
  final Widget? suffixIcon;
  final bool obscureText;
 final String? prefixText;

  const AppTextField({
    super.key,
    required this.controller,
    required this.label,
    this.validator,
    this.maxLength,
    this.suffixIcon,
    this.obscureText = false, 
    this.prefixText,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _isHovered = false;
  bool _isFocused = false;

@override
Widget build(BuildContext context) {
  final theme = Theme.of(context);
  final primaryColor = theme.colorScheme.primary;
  final borderColor = theme.brightness == Brightness.dark
      ? Colors.white70
      : Colors.black;

  final borderRadius = BorderRadius.circular(4.0);

  return MouseRegion(
    onEnter: (_) {
      setState(() => _isHovered = true);
    },
    onExit: (_) {
      setState(() => _isHovered = false);
    },
    child: Focus(
      onFocusChange: (focused) {
        setState(() => _isFocused = focused);
      },
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.obscureText,
        maxLength: widget.maxLength,
        validator: widget.validator,
        style: TextStyle(
          color: theme.brightness == Brightness.dark
            ? Colors.white70
            : Colors.black,
        ),
        decoration: InputDecoration(
          prefixText: widget.prefixText,
          labelText: widget.label,
          suffixIcon: widget.suffixIcon,
          errorMaxLines: 2,

          enabledBorder: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide: BorderSide(
              color: borderColor,
              width: _isHovered ? 1.0 : 0.5,
            ),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide: BorderSide(
              color: primaryColor,
              width: 1.5,
            ),
          ),

          errorBorder: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 184, 18, 0),
              width: 1.0,
            ),
          ),

          focusedErrorBorder: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 184, 18, 0),
              width: 2,
            ),
          ),
        ),
      )
    ),
  );
}
}
