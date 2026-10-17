import 'package:flutter/material.dart';
import 'card_bg.dart';

const Color appbgcolor = Color.fromARGB(255, 185, 251, 164);

void main() {
  runApp(const CardExampleApp());
}

class CardExampleApp extends StatelessWidget {
  const CardExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(

        backgroundColor: appbgcolor,
        body: const CardBackground(
          name: 'Consuelo B. Mercado',
          program:'BS Applied Mathematics\nSpecialization in Information Technology',
          motto: 'When life gives you lemons, make mojitos.',
        ),
      ),
    );
  }
}