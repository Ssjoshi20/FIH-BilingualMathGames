import 'package:flutter/material.dart';
import 'package:vedicmath/screens/learn_rule_5/learn_screen.dart';
import 'package:vedicmath/screens/learn_rule_4/learn_screen.dart';
import 'package:vedicmath/screens/learn_rule_3/learn_screen.dart';
import 'package:vedicmath/screens/learn_rule_1/intro_screen.dart';
import 'package:vedicmath/screens/learn_rule_2/learn_screen.dart';
import 'components/gradient_app_bar.dart';
import 'package:vedicmath/global.dart';
import 'package:audioplayers/audioplayers.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late AudioPlayer _audioPlayer;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _playSoundEffect() async {
    // await _audioPlayer.play(AssetSource('button_click.mp3'));
  }

  void _onIntroPressed() {
    _playSoundEffect();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const IntroScreen()),
    );
  }

  void _onLearnPressed() {
    _playSoundEffect();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LearnScreen()),
    );
  }

  void _onLearn_5_Pressed() {
    _playSoundEffect();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LearnScreen_5()),
    );
  }

  void _onLearn_1_Pressed() {
    _playSoundEffect();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LearnScreen_1()),
    );
  }

  void _onLearn_6_Pressed() {
    _playSoundEffect();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LearnScreen_6()),
    );
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

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
            colors: [
              Color(0xffca485c),
              Color(0xFFFFB74D),
            ],
          ),
        ),
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
              ),
              Image.asset(
                'assets/vedicmaths-logo_f-229x300.jpg',
                fit: BoxFit.contain,
                height: MediaQuery.of(context).size.height * 0.30,
              ),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(128, 0, 128, 0.9),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Score: $score',
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: _onIntroPressed,
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: const Color(0xFFE53935),
                          elevation: 5,
                          minimumSize: const Size(300, 100),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              'assets/introduction_image.png',
                              width: 50,
                              height: 50,
                              alignment: Alignment.centerLeft,
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              'Rule 1',
                              style: TextStyle(fontSize: 30),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: _onLearn_1_Pressed,
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: const Color(0xFFE53935),
                          elevation: 5,
                          minimumSize: const Size(300, 100),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              'assets/Addition.png',
                              width: 50,
                              height: 50,
                              alignment: Alignment.centerLeft,
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              'Rule 2',
                              style: TextStyle(fontSize: 30),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: _onLearn_5_Pressed,
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: const Color(0xFFE53935),
                          elevation: 5,
                          minimumSize: const Size(300, 100),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              'assets/Multiply.png',
                              width: 50,
                              height: 50,
                              alignment: Alignment.centerLeft,
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              'Rule 3',
                              style: TextStyle(fontSize: 30),

                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: _onLearnPressed,
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: const Color(0xFFE53935),
                          elevation: 5,
                          minimumSize: const Size(300, 100),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              'assets/Div.png',
                              width: 50,
                              height: 50,
                              alignment: Alignment.centerLeft,
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              'Rule 4',
                              style: TextStyle(fontSize: 30),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: _onLearn_6_Pressed,
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: const Color(0xFFE53935),
                          elevation: 5,
                          minimumSize: const Size(300, 100),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              'assets/Multiply.png',
                              width: 50,
                              height: 50,
                              alignment: Alignment.centerLeft,
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              'Rule 5',
                              style: TextStyle(fontSize: 30),

                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: _onLearnPressed,
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: const Color(0xFFE53935),
                          elevation: 5,
                          minimumSize: const Size(300, 100),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              'assets/introduction_image.png',
                              width: 50,
                              height: 50,
                              alignment: Alignment.centerLeft,
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              'Rule 6',
                              style: TextStyle(fontSize: 30),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _scrollToTop,
        child: const Icon(Icons.arrow_upward),
        backgroundColor: const Color(0xffca485c),
      ),
    );
  }
}
