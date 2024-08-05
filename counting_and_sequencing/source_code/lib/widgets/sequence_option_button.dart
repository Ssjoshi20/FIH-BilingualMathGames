import 'package:flutter/material.dart';

class SequenceOptionButton extends StatelessWidget {
  final BuildContext context;
  final String text;
  final VoidCallback onPressed;

  const SequenceOptionButton({
    Key? key,
    required this.context,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(fontSize: 30),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.purple,
          padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
        ),
      ),
    );
  }
}