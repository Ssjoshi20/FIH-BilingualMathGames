import 'package:flutter/material.dart';
import 'count_match_demo.dart';
import 'sequence_demo.dart';
class DemoGame extends StatelessWidget {
  const DemoGame({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Demo Game"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  CountMatchDemo()),
              ),
              child: Text(
                "Go to Count Match Game",
                style: TextStyle(fontSize: 30.0, color: Colors.white),
              ),
            ),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SequenceDemo()),
              ),
              child: Text(
                "Go to Sequence Game",
                style: TextStyle(fontSize: 30.0, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
