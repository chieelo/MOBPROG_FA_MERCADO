import 'package:flutter/material.dart';
import 'package:fa2_simple_quiz_app/commons/styled_text.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen(this.switchScreen, {super.key});

  final void Function() switchScreen;

  void outlinedButtonPressed() {
    switchScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/bgclear.png'),opacity: 0.7,
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10,
          children: [
            Image.asset(
              'assets/amitlogo.png',
              width: 100,
              height: 100,
            ),

            const SizedBox(height: 10),

            StyledText(
              'Only Amit Knows (OAK)',
              24,
              color: Colors.white,
            ),

            OutlinedButton.icon(
              onPressed: outlinedButtonPressed,
              style: OutlinedButton.styleFrom(
                backgroundColor:
                    const Color.fromARGB(255, 97, 147, 172),
                side: const BorderSide(color: Colors.white),
              ),
              icon: const Icon(
                Icons.lightbulb,
                color: Colors.white,
                size: 24,
              ),
              label: StyledText(
                'Test your Amitness',
                14,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

