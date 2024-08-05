import 'package:flutter/material.dart';
import '../screens/fivepage.dart';
import '../screens/twopage.dart';

class CountMatchDemo extends StatefulWidget {
  const CountMatchDemo({super.key});
  @override
  State<CountMatchDemo> createState() =>  _CountMatchDemoState();
}
class _CountMatchDemoState extends State<CountMatchDemo> {

  bool showSpanish = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Count Match Game'),
      ),
      body: Container(
        color: Colors.purple[100],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              alignment: Alignment.center,
              child: Text(
                showSpanish
                    ? 'Veamos cuántas uvas tenemos'
                    : 'Let\'s see how many grapes we have',
                style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              height: 48,
              margin: EdgeInsets.symmetric(horizontal: 50.0),
              decoration: BoxDecoration(
                color: Colors.purple,
                borderRadius: BorderRadius.circular(24.0),
              ),
            ),
            SizedBox(height: 48),
            Center(
              child: Container(
                width: 330,
                height: 186,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.purple, width: 4),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Image.asset(
                      'assets/grapes.png'), // Ensure the image asset is correctly located in your project
                ),
              ),
            ),
            SizedBox(height: 48),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50.0),
              child: Tooltip(
                message: 'Click me, the count is five!', // Tooltip text
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              FivePage()), // Ensure FivePage is correctly defined elsewhere
                    );
                  },
                  child: Text(
                    showSpanish ? 'CINCO' : 'FIVE',
                    style: TextStyle(fontSize: 30.0, color: Colors.black),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(vertical: 20),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            twoPage()), // Ensure TwoPage is defined as well
                  );
                },
                child: Text(
                  showSpanish ? 'DOS' : 'TWO',
                  style: TextStyle(fontSize: 30.0, color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 20),
                ),
              ),
            ),
            SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 55.0),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    showSpanish = !showSpanish;
                  });
                },
                child: Text(showSpanish ? 'English' : 'Español',
                    style: TextStyle(fontSize: 23)),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
