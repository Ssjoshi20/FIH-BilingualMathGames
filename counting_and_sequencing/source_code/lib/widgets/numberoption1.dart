import 'package:flutter/material.dart';

class NumberOptionButton1 extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final VoidCallback onPressed;

  NumberOptionButton1(
      {required this.text,
        required this.backgroundColor,
        required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      ),
      child: Text(text, style: TextStyle(color: Colors.white, fontSize: 30)),
    );
  }
}