
import 'package:fa3_my_reading_list_expdisthmcrt/library_screens/books_screen.dart';
import 'package:flutter/material.dart';
import 'package:fa3_my_reading_list_expdisthmcrt/library_screens/home_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  var activeScreen = 'home-screen';

  void switchScreen() {
    setState(() {
      activeScreen = 'books-screen';
    });
  }

  void switchScreen1() {
    setState(() {
      activeScreen = 'home-screen';
    });
  }

  @override
  Widget build(BuildContext context) {
    final Widget currentScreen = activeScreen == 'home-screen'
        ? HomeScreen(switchScreen)
        : BookScreen(onSwitchBack: switchScreen1);

    return currentScreen;
  }
}
