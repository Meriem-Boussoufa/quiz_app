import 'package:flutter/material.dart';
import 'package:quiz_app/home.dart';
import 'package:quiz_app/question.dart';
import 'package:quiz_app/result.dart';

import 'data/questions.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  Widget? activeScreen;
  List<String> selectedAnswers = [];

  void chooseAnswer(String answer) {
    selectedAnswers.add(answer);
    if (selectedAnswers.length == questions.length) {
      setState(() {
        activeScreen = Result(selectedAnswers, restart);
      });
    }
  }

  void switchScreen() {
    setState(() {
      activeScreen = Question(chooseAnswer);
    });
  }

  void restart() {
    setState(() {
      selectedAnswers = [];
      activeScreen = Home(switchScreen);
    });
  }

  @override
  void initState() {
    super.initState();
    activeScreen = Home(switchScreen);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.deepPurpleAccent, Colors.purpleAccent])),
            child: activeScreen),
      ),
    );
  }
}
