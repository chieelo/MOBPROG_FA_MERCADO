import 'package:flutter/material.dart';

class StyledText extends StatelessWidget {
  

  const StyledText(this.text, this.fontsize, {super.key, required this.color});
  final String text;
  final double fontsize;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontsize,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.bold,
        color: color,
      ),
      textAlign: TextAlign.center,
    );
  }
}