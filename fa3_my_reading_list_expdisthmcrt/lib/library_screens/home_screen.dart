import 'package:flutter/material.dart';
import 'package:fa3_my_reading_list_expdisthmcrt/commons/styled_text.dart';

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
          image: AssetImage('assets/background.png'),
          opacity: 0.7,
          colorFilter: ColorFilter.mode(
            Color.fromARGB(64, 0, 0, 0),
            BlendMode.darken,
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 10,
            children: [
              const SizedBox(height: 160),

              Image.asset(
                'assets/book.png',
                width: 300,
                height: 300,
              ),


              OutlinedButton.icon(
                onPressed: outlinedButtonPressed,
                style: OutlinedButton.styleFrom(
                  backgroundColor:
                      const Color.fromARGB(255, 97, 147, 172),
                  side: const BorderSide(color: Colors.white),
                ),
                icon: const Icon(
                  Icons.library_books,
                  color: Colors.white,
                  size: 24,
                ),
                label: StyledText(
                  'Open Library',
                  14,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
