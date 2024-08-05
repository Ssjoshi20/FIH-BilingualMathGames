import 'package:flutter/material.dart';
import '../screens/home.dart';
class ExitButton extends StatelessWidget {
  final BuildContext context;

  const ExitButton({Key? key, required this.context}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage()),
        ); // This will go back to the previous screen
      },
      child: Text(
        'EXIT',
        style: TextStyle(fontSize: 30),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.purple,
        padding: EdgeInsets.symmetric(horizontal: 140, vertical: 20),
      ),
    );
  }
}