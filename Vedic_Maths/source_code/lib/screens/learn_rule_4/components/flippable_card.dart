import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter_tts/flutter_tts.dart';

String TTS_INPUT_1 =
    "Let's pretend we have the number 1234, and we want to share it equally among 5 friends. Instead of using the usual way, which can be a bit tricky, we'll learn a simple way to do it in just two steps and in our heads. It's like a cool shortcut!";
String TTS_INPUT_2 =
    'Vamos a suponer que tenemos el número 1234 y queremos compartirlo equitativamente entre 5 amigos. En lugar de utilizar la forma habitual, que puede ser un poco complicada, aprenderemos una manera sencilla de hacerlo en solo dos pasos y mentalmente. Es como un atajo genial';

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
        children: [
          Expanded(
            child: Row(
              children: [
                // Image on the left
                Container(
                  width: 300, // Adjust the width as needed
                  height: 400,
                  child: Image.asset(
                    'assets/divby5.png', // Replace with your image path
                    fit: BoxFit.cover,
                  ),
                ),
                // Text on the right
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      text,
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
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
