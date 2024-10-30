import 'package:flutter/material.dart';
import 'package:vedicmath/screens/timetrial/timetrial.dart';
import 'package:audioplayers/audioplayers.dart';
import '../my_home/components/gradient_app_bar.dart';
import '../my_home/my_home_screen.dart'; // Import your MyHomePage widget
import '../bingo/bingo.dart'; // Import your BingoScreen widget
import '../welcome/welcome_screen.dart'; // Import your WelcomeScreen widget
import '../crossword/crossword.dart'; // Import your CrosswordScreen widget
import '../math_craft/mathcraft.dart'; // Import your MathCraftScreen widget

class PlayScreen extends StatefulWidget {
  const PlayScreen({Key? key}) : super(key: key);

  @override
  _PlayScreenState createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _playSoundEffect() async {
    //await _audioPlayer.play(AssetSource('button_click.mp3'));
  }

  // Method to handle "Learn" button click
  void _onContinuePressed() async {
    await _playSoundEffect();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MyHomePage()),
    );
  }

  // Method to handle "Play" button click
  void _onPlayPressed() async {
    await _playSoundEffect();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const BingoScreen()),
    );
  }

  void _onTtPressed() async {
    await _playSoundEffect();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const TimeTrialWidget()),
    );
  }

  void _onCrosswordPressed() async {
    await _playSoundEffect();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const CrosswordScreen()),
    );
  }

  void _onMathCraftPressed() async {
    await _playSoundEffect();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MathCraftScreen()),
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
            colors: [Color(0xffca485c), Color(0xFFFFB74D)],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Choose Your Game',
                style: TextStyle(
                  fontSize: 80,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20), // Add spacing

              const SizedBox(height: 180),
              ElevatedButton(
                onPressed: _onTtPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  fixedSize: const Size(300, 70), // Increased size
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 5,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        'Time Trial',
                        style: TextStyle(fontSize: 35),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(width: 10), // Add additional space
                    Icon(Icons.arrow_forward),
                  ],
                ),
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: _onPlayPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      fixedSize: const Size(300, 70), // Increased size
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 5,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            'Bingo',
                            style: TextStyle(fontSize: 35),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(width: 10),
                        Icon(Icons.play_arrow),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _onCrosswordPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  fixedSize: const Size(300, 70), // Increased size
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 5,
                ),
                child: const Padding(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Crossword',
                          style: TextStyle(fontSize: 35),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(width: 10), // Add additional space
                      Icon(Icons.grid_on), // Added icon for Crossword
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _onMathCraftPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  foregroundColor: Colors.white,
                  fixedSize: const Size(300, 70), // Increased size
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 5,
                ),
                child: const Padding(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Math Craft',
                          style: TextStyle(fontSize: 35),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(width: 10), // Add additional space
                      Icon(Icons.extension), // Added icon for Math Craft
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
