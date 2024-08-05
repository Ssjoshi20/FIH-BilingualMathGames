import 'package:flutter/material.dart';

class twoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Wrong!',
          style: TextStyle(fontSize: 30.0, color: Colors.black),
        ),
        backgroundColor: Colors.purple,
      ),
      body: Container(
        color: Colors.purple[100],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(
              Icons.cancel_presentation_outlined,
              size: 120,
              color: Colors.redAccent,
            ),
            SizedBox(height: 48),
            Center(
              child: Text(
                'You Are Wrong!',
                style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            SizedBox(height: 48),
            ElevatedButton(
              onPressed: () {
                // Define what to do when "Try Again" button is pressed

                Navigator.pop(context);
              },
              child: Text(
                'Try Again',
                style: TextStyle(fontSize: 30.0, color: Colors.black),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(120.0),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(
                    context); // This will go back to the previous screen
              },
              child: Text(
                'EXIT',
                style: TextStyle(fontSize: 30.0, color: Colors.black),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(120.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}