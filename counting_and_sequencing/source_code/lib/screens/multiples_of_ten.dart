import 'package:flutter/material.dart';
import 'right_answer.dart';
import 'wrong_answer.dart';
import '../utils/number_generator_4.dart';
import '../widgets/non_clickable_number.dart';
import '../widgets/number_option_button.dart';
class MultiplesOfTen extends StatefulWidget {
  final int initialScore;

  MultiplesOfTen({this.initialScore = 0}); // Default score is 0 if not provided

  @override
  _MultiplesOfTenPageState createState() => _MultiplesOfTenPageState();
}

class _MultiplesOfTenPageState extends State<MultiplesOfTen> {
  bool showSpanish = false;
  List<String> sequence = [];
  String correctOption = '';
  List<String> options = [];
  late int score; // Score is now a late variable

  @override
  void initState() {
    super.initState();
    score = widget.initialScore; // Initialize score from widget property
    generateSequence();
  }

  void generateSequence() {
    sequence = NumberGenerator4.generateSequence(4);
    correctOption = NumberGenerator4.generateCorrectOption();
    options = NumberGenerator4.generateOptions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.purple[100],
        appBar: AppBar(
          title: Text('Multiples of Ten'),
          centerTitle: true,
          backgroundColor: Colors.purple,
        ),
        body: Stack(children: [
          Positioned.fill(
            child: Image.asset(
              'assets/p5.gif', // Ensure your image path is correct
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    for (String number in sequence)
                      NonClickableNumber(
                        text: showSpanish
                            ? NumberGenerator4.convertToSpanish(number)
                            : number,
                      ),
                  ],
                ),
                SizedBox(height: 32),
                Text(
                  'Choose an Option',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                for (String option in options)
                  NumberOptionButton(
                    text: showSpanish
                        ? NumberGenerator4.convertToSpanish(option)
                        : option,
                    onPressed: () {
                      setState(() {
                        if (option == correctOption) {
                          score += 10; // Add points for a correct answer
                          navigate(context, true);
                        } else {
                          score -= 5; // Subtract points for a wrong answer
                          navigate(context, false);
                        }
                      });
                    },
                  ),
                SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      showSpanish = !showSpanish;
                    });
                  },
                  child: Text(showSpanish ? 'English' : 'Español',
                      style: TextStyle(fontSize: 23)),
                ),
              ],
            ),
          ),
        ]));
  }

  void navigate(BuildContext context, bool isCorrect) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => isCorrect
            ? RightAnswerPage(
            score: score,
            onNextQuestionPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          MultiplesOfTen(initialScore: score)));
            })
            : WrongAnswerPage(score: score),
      ),
    );
  }
}
