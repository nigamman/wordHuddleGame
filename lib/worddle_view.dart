import 'package:flutter/material.dart';
import 'package:word_huddle_game/worddle.dart';

class WordleView extends StatelessWidget {
  final Wordle wordle;

  const WordleView({super.key, required this.wordle});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: wordle.existInTarget
            ? Colors.white60
            : wordle.doesNotExistInTarget
                ? Colors.blueGrey.shade700
                : null,
        border: Border.all(color: Colors.amber, width: 1.0),
      ),
      child: Text(
        wordle.letter,
        style: TextStyle(
          fontSize: 16,
          color: wordle.existInTarget ? Colors.black
              : wordle.doesNotExistInTarget ? Colors.white54
                  : Colors.white,
        ),
      ),
    );
  }
}
