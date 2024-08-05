import 'package:flutter/material.dart';

class WrongAnswerPage extends StatelessWidget {
  final int score; // Add this line to hold the score

  WrongAnswerPage({required this.score}); // Update this constructor

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wrong Answer'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Oops! Your answer is incorrect.',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            Text('Score: $score',
                style: TextStyle(fontSize: 24)), // Display the score
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Try Again', style: TextStyle(fontSize: 23)),
            ),
          ],
        ),
      ),
    );
  }
}