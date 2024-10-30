import 'package:flutter/material.dart';
import 'package:vedicmath/screens/learn_rule_3/components/flippable_card.dart';
import 'package:vedicmath/screens/learn_rule_3/components/gradient_app_bar.dart';
import 'package:vedicmath/screens/learn_rule_3/Page2.dart'; // Import Page2.dart

class LearnScreen_5 extends StatelessWidget {
  const LearnScreen_5({Key? key}) : super(key: key);

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
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text("Squares of 1's", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
              ),
              const FlippableCard(),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Navigate to Page2.dart
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Page2()),
                  );
                },
                child: Text('Next', style: TextStyle(fontSize: 28),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
