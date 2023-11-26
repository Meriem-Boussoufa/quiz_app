import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/data/questions.dart';

class Result extends StatelessWidget {
  const Result(
    this.selectedAnswers,
    this.restart, {
    super.key,
  });

  final List<String> selectedAnswers;
  final void Function() restart;

  getSummaryData() {
    final List<Map<String, Object>> summary = [];
    for (var i = 0; i < selectedAnswers.length; i++) {
      summary.add({
        'question_index': i,
        'question': questions[i].text,
        'correct_answer': questions[i].answers[0],
        'user_answer': selectedAnswers[i],
      });
    }
    return summary;
  }

  @override
  Widget build(BuildContext context) {
    var numOfCorrectAnswers = 0;

    for (var i = 0; i < selectedAnswers.length; i++) {
      if (getSummaryData()[i]['user_answer'] ==
          getSummaryData()[i]['correct_answer']) {
        numOfCorrectAnswers++;
      }
    }
    // * Alternative
    /*int numOfCorrectAnswers = getSummaryData().where(
        (element) => element['user_answer'] == element['correct_answer']).length;*/

    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(20),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 30),
              Text(
                'You answered $numOfCorrectAnswers out of ${questions.length} questions correctly!',
                style: const TextStyle(
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              ...getSummaryData().map((e) => Column(children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 16,
                          backgroundColor:
                              e['user_answer'] == e['correct_answer']
                                  ? Colors.blueAccent
                                  : Colors.red[300],
                          child: Text(
                            ((e['question_index'] as int) + 1).toString(),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                e['question'].toString(),
                                style: GoogleFonts.lato(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                e['user_answer'].toString(),
                                style: GoogleFonts.lato(
                                  color:
                                      const Color.fromARGB(146, 250, 205, 254),
                                ),
                              ),
                              Text(
                                e['correct_answer'].toString(),
                                style: GoogleFonts.lato(
                                  color:
                                      const Color.fromARGB(255, 49, 167, 203),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                  ])),
              const SizedBox(
                height: 30,
              ),
              TextButton.icon(
                  onPressed: restart,
                  icon: const Icon(Icons.restart_alt_outlined,
                      color: Color.fromARGB(255, 250, 205, 254)),
                  label: const Text(
                    'Restart Quiz! ',
                    style: TextStyle(
                      color: Color.fromARGB(255, 250, 205, 254),
                    ),
                  )),
            ]),
      ),
    );
  }
}
