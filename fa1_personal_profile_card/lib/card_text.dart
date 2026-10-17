import 'package:flutter/material.dart';

const Color txtcolor = Color.fromARGB(255, 0, 50, 91);
const double namefontSize = 24;
const double programfontSize = 14;
const double mottofontSize = 12;

class CardText extends StatelessWidget {
  final String fullname;
  final String program;
  final String motto;

  const CardText({
    super.key,
    required this.fullname,
    required this.program,
    required this.motto,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            fullname,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: namefontSize,
              fontWeight: FontWeight.w900,
              color: txtcolor,
            ),
          ),
          subtitle: Text(
            program,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: programfontSize,
              color: txtcolor,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Text(
            motto,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: mottofontSize,
              fontWeight: FontWeight.w300,
              fontStyle: FontStyle.italic,
              color: txtcolor,
            ),
          ),
        ),
      ],
    );
  }
}