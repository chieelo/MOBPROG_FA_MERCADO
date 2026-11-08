import 'package:flutter/material.dart';

const String fireflyLogo = 'assets/images/firefly_logo.png';

class FireflyLogo extends StatelessWidget {
  final double height;
  const FireflyLogo({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      fireflyLogo,
      height: height,
      fit: BoxFit.contain,
      color: Theme.of(context).colorScheme.primary,
    );
  }
}
