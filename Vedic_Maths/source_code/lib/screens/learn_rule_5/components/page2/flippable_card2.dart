import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter_tts/flutter_tts.dart';

String TTS_INPUT_1 =
    "Step 2: Add the square of the difference to the answer of step 1";
String TTS_INPUT_2 =
    "Paso 2: Suma el cuadrado de la diferencia al resultado del paso 1.";

class FlippableCard2 extends StatefulWidget {
  const FlippableCard2({Key? key}) : super(key: key);

  @override
  _FlippableCard2State createState() => _FlippableCard2State();
}

class _FlippableCard2State extends State<FlippableCard2> {
  final GlobalKey<FlipCardState> _cardKey = GlobalKey<FlipCardState>();
  FlutterTts _flutterTts = FlutterTts();
  bool _isSpeaking = false;

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
            child: Row(
              children: [
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
                        if (text == TTS_INPUT_1 || text == TTS_INPUT_2)
                          SizedBox(height: 100),
                        if (text == TTS_INPUT_1 || text == TTS_INPUT_2)
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '7 * 7 = 49',
                                  style: TextStyle(
                                    fontSize: 35,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  text == TTS_INPUT_1
                                      ? '8600 + 49 = 8649'
                                      : '8600 + 49 = 8649',
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
              ],
            ),
          ),
          Spacer(),
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
        child: FlippableCard2(),
      ),
    ),
  ));
}
