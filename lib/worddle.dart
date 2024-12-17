class Wordle {
  String letter;
  bool existInTarget;
  bool doesNotExistInTarget;

  Wordle({
    required this.letter,
    this.existInTarget = false,
    this.doesNotExistInTarget = false,
  });
}