import 'package:flutter/material.dart';
import 'package:vedicmath/screens/learn_rule_2//Page2.dart';
import 'package:vedicmath/screens/learn_rule_2/components/gradient_app_bar.dart';
import 'package:confetti/confetti.dart';
import 'dart:math';
import 'package:vedicmath/global.dart';
class QuizWidget extends StatefulWidget {
  const QuizWidget({Key? key}) : super(key: key);

  @override
  _QuizWidgetState createState() => _QuizWidgetState();
}

class _QuizWidgetState extends State<QuizWidget> {
  String? _selectedAnswer;
  bool _isAnswerCorrect = false;
  bool _isSubmitted = false;
  bool _showingHint = false;
  late ConfettiController _centerController;

  @override
  void initState() {
    super.initState();

    // initialize confettiController
    _centerController =
        ConfettiController(duration: const Duration(seconds: 10));
  }

  @override
  void dispose() {
    // dispose the controller
    _centerController.dispose();
    super.dispose();
  }

  final Map<String, Object> _question = {
    'questionText': 'Twelve multiplied by thirteen',
    'questionNum': '12 * 13',
    'correctAnswer': 'One hundred and fifty six',
    'correctAnsNum': '156',
  };

  final List<String> _ans = [
    'Twenty',
    'One hundred and fifty six',
    'One hundred and twenty',
    'Twenty-Two . Six'
  ];
  final List<String> _ansNum = ['20', '156', '120', '24.6'];

  void _answerQuestion(int index) {
    if (_isAnswerCorrect && _isSubmitted) {
      return;
    }
    setState(() {
      _isSubmitted = false;
      _selectedAnswer = _ans[index];
    });
  }

  void _handleBackPress() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const Page2()));
  }

  void _submitAnswer() {
    String correctAnswer = _question['correctAnswer'] as String;
    setState(() {
      _isSubmitted = true;
      _isAnswerCorrect = _selectedAnswer == correctAnswer;
    });
    if(_isAnswerCorrect && _isSubmitted) {
      print("pla");
      score=score+5;
      _centerController.play();
    }
  }

  Color? _getBackgroundColor(int index) {
    String option = _ans[index];
    if (_isSubmitted) {
      if (_selectedAnswer == option && _isAnswerCorrect) {
        return Colors.green;
      } else if (_selectedAnswer == option && !_isAnswerCorrect) {
        return Colors.red;
      }
    } else {
      if (_selectedAnswer == option) {
        return Colors.yellow;
      }
    }
    return null;
  }

  void _handleHint() {
    print("hint");
    setState(() {
      _showingHint = !_showingHint;
    });
  }

  void _nextQuestion() {
    print("next");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const GradientAppBar(
          title: Padding(
            padding: EdgeInsets.only(top: 25.0),
            child: Text(
              'Vedic Mathematics',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Color(0xFFE0F7FA),
              ),
            ),
          ),
          height: kToolbarHeight,
          backgroundColor: Color(0xffca485c),
        ),
        body: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: ConfettiWidget(
                confettiController: _centerController,
                blastDirection: pi / 2,
                maxBlastForce: 5,
                minBlastForce: 1,
                emissionFrequency: 0.03,

                // 10 paticles will pop-up at a time
                numberOfParticles: 10,

                // particles will pop-up
                gravity: 0,
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xffca485c),
                    Color(0xFFFFB74D)
                  ], // Reversed gradient colors
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment:  CrossAxisAlignment.start,
                children: <Widget>[
                  QuestionText(
                      questionText: _showingHint
                          ? _question['questionNum'] as String
                          : _question['questionText'] as String),
                  Container(
                    padding: const EdgeInsets.only(
                        left: 200, right: 200, top: 75, bottom: 75),
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 5,
                        mainAxisSpacing: 40.0,
                        crossAxisSpacing: 100.0,
                      ),
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return ElevatedButton(
                          onPressed: () => _answerQuestion(index),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _getBackgroundColor(index),
                          ),
                          child: Text(
                              _showingHint ? _ansNum[index] : _ans[index],
                              style: const TextStyle(
                                  fontSize: 30, color: Colors.black)),
                        );
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed:
                        _isAnswerCorrect && _isSubmitted ? null : _submitAnswer,
                    child: const Text('Submit', style: TextStyle(fontSize: 28)),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: _handleBackPress,
                        child: const Text('Back', style: TextStyle(fontSize: 28)),
                      ),
                      ElevatedButton(
                        onPressed: !_isAnswerCorrect || !_isSubmitted
                            ? null
                            : _nextQuestion,
                        child: const Text('Next', style: TextStyle(fontSize: 28)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _handleHint,
          child: const Icon(Icons.help),
        ));
  }
}

class QuestionText extends StatelessWidget {
  final String questionText;
  const QuestionText({Key? key, required this.questionText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.white))),
      // padding: const EdgeInsets.only(bottom: 10,right: 200),
      // margin: const EdgeInsets.only(left: 20),
      child: Text(
        questionText,
        style: const TextStyle(
            fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white),
        textAlign: TextAlign.left,
      ),
    );
  }
}
