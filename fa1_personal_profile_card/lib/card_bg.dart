import 'package:flutter/material.dart';
import 'card_profile.dart';
import 'card_text.dart';

const double cardwidth = 350;
const double cardradius = 12;
const Color gradient1 = Color.fromARGB(255, 251, 255, 42);
const Color gradient2 = Color.fromARGB(255, 112, 231, 122);

class CardBackground extends StatelessWidget {
  final String name;
  final String program;
  final String motto;

  const CardBackground({
    super.key,
    required this.name,
    required this.program,
    required this.motto,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: cardwidth,
  
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              gradient1,
              gradient2,
            ],

            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(cardradius),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),

        
        child: Card(
          color: Colors.transparent,
          elevation: 0,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(cardradius),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CardProfile(
              ),
              CardText(
                fullname: name,
                program: program,
                motto: motto,
              ),
            ],
          ),
        ),
      ),
    );
  }
}