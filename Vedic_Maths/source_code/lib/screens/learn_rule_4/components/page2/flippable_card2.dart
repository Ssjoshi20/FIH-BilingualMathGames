import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter_tts/flutter_tts.dart';

class FlippableCard2 extends StatefulWidget {
  const FlippableCard2({Key? key}) : super(key: key);

  @override
  _FlippableCard2State createState() => _FlippableCard2State();
}

class _FlippableCard2State extends State<FlippableCard2> {
  final GlobalKey<FlipCardState> _cardKey = GlobalKey<FlipCardState>();
  FlutterTts _flutterTts = FlutterTts();
  late String _currentText;
  bool _isSpeaking = false;

  String TTS_INPUT_1 =
      "Step 2: Move the decimal point left by 1 space";
  String TTS_INPUT_2 =
      'Paso 2: Mueve el punto decimal hacia la izquierda en 1 espacio';

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
      width: 500,
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
            padding: EdgeInsets.all(32.0),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
              ),
            ),
          ),
          // Image below the text
          Image.asset(
            'assets/step2_divby5.png', // Replace with your image path
            height: 400, // Adjust the height as needed
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
