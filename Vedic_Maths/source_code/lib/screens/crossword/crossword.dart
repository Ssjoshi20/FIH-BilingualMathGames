import 'dart:math';
import 'package:crossword/crossword.dart';
import 'package:flutter/material.dart';
import '../my_home/components/gradient_app_bar.dart'; // Import GradientAppBar
import '../welcome/play.dart'; // Import your PlayScreen widget
import 'package:vedicmath/global.dart';
import 'easy_crossword.dart';  // Import the Easy crossword screen
import 'medium_crossword.dart';  // Import the Medium crossword screen
import 'hard_crossword.dart';  // Import the Hard crossword screen
import 'expert_crossword.dart';  // Import the Expert crossword screen

class CrosswordScreen extends StatelessWidget {
  const CrosswordScreen({Key? key}) : super(key: key);

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
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xffca485c), Color(0xFFFFB74D)],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Select Difficulty',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 40),
              DifficultyButton(
                label: 'Easy (5x5)',
                color: Colors.lightGreen, // Light Green for Easy
                textColor: Colors.white, // White text for easy
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const EasyCrosswordScreen()),
                  );
                },
              ),
              const SizedBox(height: 20),
              DifficultyButton(
                label: 'Medium (7x7)',
                color: Colors.yellow, // Yellow for Medium
                textColor: Colors.black, // Black text for better contrast
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MediumCrosswordScreen()),
                  );
                },
              ),
              const SizedBox(height: 20),
              DifficultyButton(
                label: 'Hard (9x9)',
                color: Colors.redAccent.shade700, // Dark Red for Hard
                textColor: Colors.white, // White text for hard
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HardCrosswordScreen()),
                  );
                },
              ),
              const SizedBox(height: 20),
              DifficultyButton(
                label: 'Expert (11x11)',
                color: Colors.purple, // Purple for Expert
                textColor: Colors.white, // White text for expert
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ExpertCrosswordScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DifficultyButton extends StatelessWidget {
  final String label;
  final Color color;
  final Color textColor; // Add textColor property
  final VoidCallback onPressed;

  const DifficultyButton({
    Key? key,
    required this.label,
    required this.color,
    required this.textColor, // Add textColor to constructor
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color, // Use the passed color
        foregroundColor: textColor, // Use the passed text color
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        textStyle: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      child: Text(label),
    );
  }
}
