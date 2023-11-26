import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/answer_button.dart';
import 'package:quiz_app/data/questions.dart';

class Question extends StatefulWidget {
  const Question(this.onSelectedAnswer, {super.key});

  final void Function(String) onSelectedAnswer;

  @override
  State<Question> createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  var currentQuestionIndex = 0;

  void answerQuestion(String answer) {
    // Stock the answer
    widget.onSelectedAnswer(answer);
    setState(() {
      currentQuestionIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentquestion = questions[currentQuestionIndex];
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(20),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              currentquestion.text,
              style: GoogleFonts.lato(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            ...currentquestion.getShuffledAnswers().map((e) {
              return Container(
                  margin: const EdgeInsets.all(5),
                  child: AnswerButton(
                    answerText: e,
                    onPressed: () {
                      answerQuestion(e);
                    },
                  ));
            }),
          ]),
    );
  }
}
