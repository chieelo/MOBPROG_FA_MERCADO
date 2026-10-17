import 'package:flutter/material.dart';
import 'package:fa2_simple_quiz_app/commons/styled_text.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({
    super.key,
    required this.score,
    required this.switchScreen,
  });

  final int score;
  final VoidCallback switchScreen;

  static const int totalQuestions = 5;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/feubg.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(100),
          child: Column(
            mainAxisSize: MainAxisSize.min,

            children: [
              Image.asset(
                'assets/tamz.png',
                width: 150,
                height: 150,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 20),

              const StyledText(
                'AmiTest Complete!',
                24,
                color: Colors.white,
              ),

              const SizedBox(height: 20),

              StyledText(
                'Your amitness is $score out of $totalQuestions',
                20,
                color: Colors.white,
              ),

              const SizedBox(height: 30),
              OutlinedButton.icon(
                onPressed: switchScreen, 
                style: OutlinedButton.styleFrom(
                backgroundColor:
                    const Color.fromARGB(255, 97, 147, 172),
                side: const BorderSide(color: Colors.white),
              ),
                label: StyledText('Restart', 14, color: Colors.white),
                icon: const Icon(Icons.refresh, color: Colors.white,
                size: 24,),)
            ],
          ),
        ),
      ),
    );
  }
}