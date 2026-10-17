class TestQuestion {
  const TestQuestion(
    this.text,
    this.choices,
    this.correctAnswer,
  );

  final String text;
  final List<String> choices;
  final String correctAnswer;

  List<String> getShuffledAnswers() {
    final shuffledList = List<String>.from(choices);
    shuffledList.shuffle();

    return shuffledList;
  }
}