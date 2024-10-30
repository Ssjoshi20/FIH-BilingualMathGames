import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter_tts/flutter_tts.dart';

// Text-to-Speech inputs
const String TTS_INPUT_1 = "Step 2: Write 25 after the result of part 1";
const String TTS_INPUT_2 = "Paso 2: Escribe 25 después del resultado del paso 1.";

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
      front: _buildCard(TTS_INPUT_1, 'en-US'),
      back: _buildCard(TTS_INPUT_2, 'es-ES'),
    );
  }

  Widget _buildCard(String text, String language) {
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
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
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
                  SizedBox(height: 100),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '12 25',
                          style: TextStyle(
                            fontSize: 35,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (_isSpeaking) {
                stopSpeaking();
              } else {
                speak(text, language: language);
              }
            },
            child: Text(_isSpeaking ? 'Stop' : 'Speak'),
          ),
        ],
      ),
    );
  }
}
