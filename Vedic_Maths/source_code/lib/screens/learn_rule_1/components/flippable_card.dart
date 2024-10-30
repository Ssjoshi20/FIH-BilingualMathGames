import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter_tts/flutter_tts.dart';

String TTS_INPUT_1 =
    "Let's pretend we have the number 35, and we want to find its square. Instead of using the usual way, which can be a bit tricky, we'll learn a simple way to do it in just two steps and in our heads. It's like a cool shortcut!";
String TTS_INPUT_2 =
    'Imaginemos que tenemos el número 35 y queremos encontrar su cuadrado. En lugar de usar el método habitual, que puede ser un poco complicado, aprenderemos una manera simple de hacerlo en solo dos pasos y en nuestras cabezas. ¡Es como un atajo genial!';

class FlippableCard extends StatefulWidget {
  const FlippableCard({Key? key}) : super(key: key);

  @override
  _FlippableCardState createState() => _FlippableCardState();
}

class _FlippableCardState extends State<FlippableCard> {
  final GlobalKey<FlipCardState> _cardKey = GlobalKey<FlipCardState>();
  final FlutterTts _flutterTts = FlutterTts();

  bool _isSpeaking = false;
  late String _currentText;

  @override
  void initState() {
    super.initState();
    _currentText = TTS_INPUT_1;
    _flutterTts.setCompletionHandler(() {
      setState(() {
        _isSpeaking = false;
      });
    });
  }

  Future<void> _speak(String text, {String? language}) async {
    await _flutterTts.setLanguage(language ?? 'en-US');
    await _flutterTts.setPitch(1.0);
    await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.speak(text);
    setState(() {
      _isSpeaking = true;
    });
  }

  Future<void> _stopSpeaking() async {
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
      onFlipDone: (isFront) {
        if (!isFront) {
          _stopSpeaking();
        }
      },
      front: _buildCard(TTS_INPUT_1, 'en-US'),
      back: _buildCard(TTS_INPUT_2, 'es-ES'),
    );
  }

  Widget _buildCard(String text, String language) {
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
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 36,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (_isSpeaking) {
                _stopSpeaking();
              } else {
                _speak(text, language: language);
              }
            },
            child: Text(_isSpeaking ? 'Stop' : 'Speak'),
          ),
        ],
      ),
    );
  }
}

void main() => runApp(MaterialApp(home: Scaffold(body: Center(child: FlippableCard()))));
