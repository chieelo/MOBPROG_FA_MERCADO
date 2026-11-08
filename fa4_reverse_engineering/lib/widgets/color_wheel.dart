import 'package:flutter/material.dart';

class ColorWheel extends StatelessWidget {
  final Color color;
  final double size;

  const ColorWheel({
    super.key,
    required this.color,
    this.size = 28,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      color: color,
    );
  }
}