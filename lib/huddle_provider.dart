import 'package:flutter/foundation.dart';
import 'dart:math';
import 'package:english_words/english_words.dart' as words;
import 'package:word_huddle_game/worddle.dart';

class HuddleProvider extends ChangeNotifier {
  final random = Random.secure();
  List<String> totalWords = [];
  List<String> rowInputs = [];
  List<String> excludedLetters = [];
  List<Wordle> hurddleBoard = [];
  String targetWord = '';
  int count = 0;
  final lettersByRow = 5;
  int index= 0;
  bool wins = false;
  final totalAttempts = 6;
  int attempts = 0;

  bool get shouldCheckAns => rowInputs.length == lettersByRow;

  bool get noAttemptsLeft => attempts == totalAttempts;

  //for selection of 5 letters word from library and store in total words
  init() {
    totalWords = words.all.where((element) => element.length==5).toList();
    generateBoard();
    generateRandomWord();
  }


  generateBoard() {
    hurddleBoard = List.generate(30, (index) => Wordle(letter: ''));
  }

  //from this fxn we have to generate random word of 5Letters
  generateRandomWord() {
    targetWord = totalWords[random.nextInt(totalWords.length)].toUpperCase();
    print(targetWord);
  }
  bool get isValidWord => totalWords.contains(rowInputs.join('').toLowerCase());

  inputLetter(String letter) {
     if(count < lettersByRow) {
       count++;
       rowInputs.add(letter);
       hurddleBoard[index] = Wordle(letter: letter);
       index++;
       print(rowInputs);
       notifyListeners();
     }
  }

  void deleteLetter() {
    if (rowInputs.isNotEmpty) {
      rowInputs.removeAt(rowInputs.length-1);
    }
    if(count > 0) {
      hurddleBoard[index-1] = Wordle(letter: '');
      count--;
      index--;
    }
    notifyListeners();
  }

  void checkAnswer() {
    final input = rowInputs.join('');
    if(targetWord == input) {
      wins = true;
    }
    else {
      _markLetterOnBoard();
      if(attempts < totalAttempts) {
        _goToNextRow();
      }

    }
  }

  void _markLetterOnBoard() {
    for(int i = 0; i < hurddleBoard.length; i++) {

      if(hurddleBoard[i].letter.isNotEmpty && targetWord.contains(hurddleBoard[i].letter)) {
        hurddleBoard[i].existInTarget = true;
      }
      else if (hurddleBoard[i].letter.isNotEmpty && !targetWord.contains(hurddleBoard[i].letter)) {
        hurddleBoard[i].doesNotExistInTarget = true;
        excludedLetters.add(hurddleBoard[i].letter);
      }
    }
    notifyListeners();
  }

  void _goToNextRow() {
    attempts++;
    count = 0;
    rowInputs.clear();
  }
  reset() {
    count = 0;
    index = 0;
    rowInputs.clear();
    hurddleBoard.clear();
    excludedLetters.clear();
    attempts = 0;
    wins = false;
    targetWord = '';
    generateBoard();
    generateRandomWord();
    notifyListeners();
  }
}
