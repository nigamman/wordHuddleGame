import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:word_huddle_game/helper_function.dart';
import 'package:word_huddle_game/huddle_provider.dart';
import 'package:word_huddle_game/keyboard_view.dart';
import 'package:word_huddle_game/worddle_view.dart';

class WordHuddlePage extends StatefulWidget {
  const WordHuddlePage({super.key});

  @override
  State<WordHuddlePage> createState() => _WordHuddlePageState();
}

class _WordHuddlePageState extends State<WordHuddlePage> {
  @override
  void didChangeDependencies() {
    Provider.of<HuddleProvider>(context, listen: false).init();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Word Huddle',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(children: [
          Expanded(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: Consumer<HuddleProvider>(
                builder: (context, provider, child) => GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                  ),
                  itemCount: provider.hurddleBoard.length,
                  itemBuilder: (context, index) {
                    final wordle = provider.hurddleBoard[index];
                    return WordleView(wordle: wordle);
                  },
                ),
              ),
            ),
          ),
            Consumer<HuddleProvider>(
              builder: (context, provider, child) => KeyboardView(
                  excludedLetters: provider.excludedLetters,
                  onPressed: (value) {
                   provider.inputLetter(value);
                  },
              ),
            ),
          Padding(
              padding: const EdgeInsets.all(16.0),
            child: Consumer<HuddleProvider>(builder: (context,provider,child) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: () {
                  provider.deleteLetter();
                },
                    child: const Text('DELETE'),
                ),
                ElevatedButton(onPressed: () {
                  // if(!provider.isValidWord) {
                  //   showMsg(context, 'Not A Desired Word');
                  //   return;
                  // }
                  if(provider.shouldCheckAns) {
                    provider.checkAnswer();
                  }
                  if(provider.wins) {
                    showResult(context: context, title: 'YOU WIN!!!', body:'The word was ${provider.targetWord}',
                        onPlayAgain: () {
                            Navigator.pop(context);
                            provider.reset();
                        },
                        onCancel: () {
                            Navigator.pop(context);
                        },
                    );
                  }
                  else if(provider.noAttemptsLeft) {
                    showResult(context: context, title: 'YOU LOST!!!',
                        body: 'The word was ${provider.targetWord}',
                      onPlayAgain: () {
                        Navigator.pop(context);
                        provider.reset();
                      },
                      onCancel: () {
                        Navigator.pop(context);
                      },
                    );
                  }
                },
                  child: const Text('SUBMIT'),
                ),
              ],
            ),
            ),
          ),
        ]),
      ),
    );
  }
}
