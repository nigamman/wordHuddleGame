import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:word_huddle_game/word_huddle_page.dart';
import 'package:provider/provider.dart';
import 'huddle_provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => HuddleProvider(),
      child: const MyApp())
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Word Huddle',
      theme: ThemeData(
          brightness: Brightness.dark,
        ),
      home: const WordHuddlePage(),
    );
  }
}
