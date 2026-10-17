import 'package:flutter/material.dart';
import 'package:fa2_simple_quiz_app/commons/button.dart';
import 'package:fa2_simple_quiz_app/commons/styled_text.dart';
import 'package:fa2_simple_quiz_app/data/question_data.dart';
import 'package:fa2_simple_quiz_app/models/questions.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen(this.switchScreen, {super.key});

  final void Function(int score) switchScreen;

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  var questionIndex = 0;
  var score = 0;

  void answerQuestion(String answer) {
    final currentQuestion = questions[questionIndex];

    if (answer == currentQuestion.correctAnswer) {
      score++;
    }

    if (questionIndex == questions.length - 1) {
      widget.switchScreen(score);
    } 
    
    else {
      setState(() {
        questionIndex++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    TestQuestion currentQuestion = questions[questionIndex];

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/feubg.png'),fit: BoxFit.cover,),),
            child: Center(
              child: Container(
                margin: const EdgeInsets.all(100),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: 10,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: StyledText(
                        'Score: $score',
                        16,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 20),

                    StyledText(
                      currentQuestion.text,
                      20,
                      color: Colors.white,
                    ),

                    ...currentQuestion.getShuffledAnswers().map(
                      (answer) => StyledButton(
                        text: answer,
                        onPressed: () => answerQuestion(answer),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      }