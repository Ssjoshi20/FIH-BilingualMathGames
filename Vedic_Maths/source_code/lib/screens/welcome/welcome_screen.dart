import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:vedicmath/screens/timetrial/timetrial.dart';
import 'package:audioplayers/audioplayers.dart';

import '../my_home/my_home_screen.dart'; // Import your MyHomePage widget
import '../bingo/bingo.dart'; // Import your BingoScreen widget
import '../welcome/play.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  double opacity = 0.0; // Initial opacity value
  double rocketPosition = 0.0; // Initial rocket position
  bool rocketVisible = false;
  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    // Call the method to start the animation
    _startAnimation();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _playSoundEffect() async {
    //await _audioPlayer.play(AssetSource('button_click.mp3'));
  }

  // Method to start the animation
  void _startAnimation() {
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        opacity = 1.0; // Set opacity to fully visible
      });

      Future.delayed(const Duration(milliseconds: 500), () {
        setState(() {
          rocketPosition = MediaQuery.of(context).size.height *
              0.025; // Set rocket position for animation
          rocketVisible = true; // Show the rocket
        });
      });
    });
  }

  // Method to handle "Learn" button click
  void _onContinuePressed() async {
    await _playSoundEffect();
    setState(() {
      rocketPosition = MediaQuery.of(context).size.height *
          1.2; // Set rocket position for animation (off the screen)
    });

    // Add any additional logic or navigation here

    // Delay for a moment to give time for the rocket to animate off the screen
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MyHomePage()),
      );
    });
  }

  // Method to handle "Play" button click
  void _onPlayPressed() async {
    await _playSoundEffect();
    setState(() {
      rocketPosition = MediaQuery.of(context).size.height * 1.2;
    });

    // Add any additional logic or navigation here

    // Delay for a moment to give time for the rocket to animate off the screen
    Future.delayed(const Duration(seconds: 1), () {
      // Navigate to the bingo.dart file
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
            const PlayScreen()), // Navigate to BingoScreen
      );
    });
  }

  void _onTtPressed() async {
    await _playSoundEffect();
    setState(() {
      rocketPosition = MediaQuery.of(context).size.height * 1.2;
    });

    // Add any additional logic or navigation here

    // Delay for a moment to give time for the rocket to animate off the screen
    Future.delayed(const Duration(seconds: 1), () {
      // Navigate to the bingo.dart file
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
            const TimeTrialWidget()), // Navigate to BingoScreen
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
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
                  AnimatedOpacity(
                    opacity: opacity,
                    duration: const Duration(seconds: 1),
                    child: const Text(
                      'W E L C O M E',
                      style: TextStyle(
                        fontSize: 80,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20), // Add spacing
                  DefaultTextStyle(
                    style: const TextStyle(
                      fontSize: 30.0,
                      fontFamily: 'Agne',
                    ),
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText('¡Hola!'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 180),
                  ElevatedButton(
                    onPressed: _onContinuePressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      fixedSize: const Size(200, 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 5,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.only(
                          right: 10.0), // Add right padding to create space
                      child: Row(
                        children: [
                          Text(
                            'Learn',
                            style: TextStyle(fontSize: 35),
                          ),
                          SizedBox(
                              width:
                              10), // Add additional space between button and rocket
                          Icon(Icons.arrow_forward),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(width: 20),
                      ElevatedButton(
                        onPressed: _onPlayPressed, // Call _onPlayPressed method
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green, // Set button color
                          foregroundColor: Colors.white, // Set text color
                          minimumSize: const Size(200, 60), // Set button size
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(10), // Set button shape
                          ),
                          elevation: 5, // Add elevation
                        ),
                        child: const Padding(
                          padding: EdgeInsets.only(right: 10.0),
                          child: Row(
                            children: [
                              Text(
                                'Play', // Button text
                                style: TextStyle(
                                    fontSize: 35), // Button text style
                              ),
                              SizedBox(
                                  width:
                                  10), // Add space between button text and icon
                              Icon(Icons.play_arrow), // Icon
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),

                    ],
                  ),
                ],
              ),
            ),
          ),
          if (rocketVisible)
            AnimatedPositioned(
              duration: const Duration(seconds: 1),
              curve: Curves.easeInOut,
              bottom: rocketPosition,
              left: MediaQuery.of(context).size.width * 0.5 - 100, // Center the rocket horizontally
              child: Image.asset(
                'assets/Rocket.png', // Replace with the actual path to your Rocket image
                width: 200,
                height: 200,
              ),
            ),
        ],
      ),
    );
  }
}
