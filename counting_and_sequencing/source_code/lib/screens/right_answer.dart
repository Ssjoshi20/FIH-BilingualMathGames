import 'package:flutter/material.dart';
class RightAnswerPage extends StatelessWidget {
  final VoidCallback onNextQuestionPressed;
  final int score; // Add this line to hold the score

  RightAnswerPage(
      {required this.onNextQuestionPressed,
        required this.score}); // Update this constructor

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Right Answer'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Congratulations! You answered correctly.',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            Text('Score: $score',
                style: TextStyle(fontSize: 24)), // Display the score
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: onNextQuestionPressed,
              child: Text(
                'Next Question',
                style: TextStyle(fontSize: 23),
              ),
            ),
          ],
        ),
      ),
    );
  }
}