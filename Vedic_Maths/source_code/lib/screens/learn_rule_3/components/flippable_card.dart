import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter_tts/flutter_tts.dart';

class FlippableCard extends StatefulWidget {
  const FlippableCard({Key? key}) : super(key: key);

  @override
  _FlippableCardState createState() => _FlippableCardState();
}

class _FlippableCardState extends State<FlippableCard> {
  final GlobalKey<FlipCardState> _cardKey = GlobalKey<FlipCardState>();
  FlutterTts _flutterTts = FlutterTts();
  late String _currentText;
  bool _isSpeaking = false;

  String TTS_INPUT_1 =
      "Imagine you have a special number made up of the digit 1, for example, 1111. Now, let's explore a fun way to find the square of this number! Squaring a number means multiplying it by itself. Instead of using long multiplication with multiple steps, you'll discover a simple and exciting trick to find the square of numbers made up of only 1's !";
  String TTS_INPUT_2 =
      "Imagina un número especial con solo el dígito 1, como 1111. Descubre de manera divertida cómo encontrar su cuadrado sin usar la multiplicación larga. ¡Aprende un truco emocionante para hallar el cuadrado de números formados solo por 1's!";

  @override
  void initState() {
    super.initState();
    _currentText = TTS_INPUT_1; // Initially set to TTS_INPUT_1
  }

  Future<void> speak(String text, {String? language}) async {
    await _flutterTts.setLanguage(language ?? 'en-US');
    await _flutterTts.setPitch(1.0);
    await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.speak(text);
    setState(() {
      _isSpeaking = true;
    });
  }

  Future<void> stopSpeaking() async {
    await _flutterTts.stop();
    setState(() {
      _isSpeaking = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlipCard(
      key: _cardKey,
      flipOnTouch: true,
      direction: FlipDirection.HORIZONTAL,
      onFlip: () {
        if (_cardKey.currentState!.isFront) {
          setState(() {
            _isSpeaking = false; // Reset speaking status when flipping to front
          });
        }
      },
      front: _buildCard(TTS_INPUT_1),
      back: _buildCard(TTS_INPUT_2),
    );
  }

  Widget _buildCard(String text) {
    return Container(
      width: 900,
      height: 600,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: Color(0xFFE27C5E),
        backgroundBlendMode: BlendMode.color,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Text in the center
          Padding(
            padding: EdgeInsets.all(22.0),
            child: Row(
              children: [
                // Image on the left
                Container(
                  width: 200, // Adjust the width as needed
                  height: 400,
                  child: Image.asset(
                    'assets/1111_squared.png', // Replace with your image path
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 30),
                // Text on the right
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          text,
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Spacer(), // Add Spacer to push the button to the bottom
          ElevatedButton(
            onPressed: () {
              if (_isSpeaking) {
                stopSpeaking();
              } else {
                speak(text, language: text == TTS_INPUT_2 ? 'es-ES' : 'en-US');
              }
            },
            child: Text(_isSpeaking ? 'Stop' : 'Speak'),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Flippable Card with TTS'),
      ),
      body: Center(
        child: FlippableCard(),
      ),
    ),
  ));
}