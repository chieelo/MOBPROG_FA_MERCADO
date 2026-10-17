import 'package:flutter/material.dart';
import 'package:fa2_simple_quiz_app/screens/home_screen.dart';
import 'package:fa2_simple_quiz_app/screens/quiz_screen.dart';
import 'package:fa2_simple_quiz_app/screens/result_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var activeScreen = 'home-screen';

  int score = 0;

  void switchScreen() {
    setState(() {
      activeScreen = 'quiz-screen';
    });
  }

  void switchScreen2(int finalScore) {
    setState(() {
      score = finalScore;
      activeScreen = 'result-screen';
    });
  }

  void switchScreen3() {
    setState(() {
      score = 0;
      activeScreen = 'home-screen';
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget currentScreen = HomeScreen(switchScreen);

    if (activeScreen == 'quiz-screen') {
      currentScreen = QuizScreen(switchScreen2);
    }

    if (activeScreen == 'result-screen') {
      currentScreen = ResultScreen(
        score: score,
        switchScreen: switchScreen3,
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AMIT Quiz',
      home: Scaffold(
        backgroundColor: Colors.blueGrey,
        body: Center(
          child: currentScreen,
        ),
      ),
    );
  }
}