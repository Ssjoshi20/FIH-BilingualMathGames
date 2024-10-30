import 'package:flutter/material.dart';
import 'package:vedicmath/screens/learn_rule_5/components/page2/flippable_card.dart';
import 'package:vedicmath/screens/learn_rule_5/components/page2/flippable_card2.dart';
import 'package:vedicmath/screens/learn_rule_5/components/gradient_app_bar.dart';
import 'package:vedicmath/screens/learn_rule_5/learn_screen.dart';
import 'package:vedicmath/screens/learn_rule_5/quiz.dart';

class Page2 extends StatelessWidget {
  const Page2({Key? key}) : super(key: key);

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    child: FlippableCard(),
                  ),
                  Flexible(
                    child: FlippableCard2(),
                  ),
                ],
            
              ),
            ),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const LearnScreen_6()));},
                  child: const Text('Back' , style: TextStyle(fontSize: 28)),
                ),
                ElevatedButton(
                  onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const QuizWidget()));},
                  child: const Text('Next' , style: TextStyle(fontSize: 28)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}