import 'dart:async';
import 'package:flutter/material.dart';
import 'package:vedicmath/screens/bingo/components/gradient_app_bar.dart';
import 'package:vedicmath/screens/welcome/welcome_screen.dart';
import 'package:vedicmath/global.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final bool isDisable;
  final bool isCorrect;

  const CustomButton({
    Key? key,
    required this.buttonText,
    required this.onPressed,
    required this.isDisable,
    required this.isCorrect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          border: Border.all(
              color: isCorrect ? Colors.green : const Color(0xffca485c), width: 5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ElevatedButton(
          onPressed: isDisable ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFFF9C4),
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          child: Text(
            buttonText,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 29),
          ),
        ),
      ),
    );
  }
}

class BingoScreen extends StatefulWidget {
  const BingoScreen({Key? key}) : super(key: key);

  @override
  State<BingoScreen> createState() => _BingoScreenState();
}

class _BingoScreenState extends State<BingoScreen> {
  List<String> bingoWords = [
    'One Hundred Two Point Four',
    'Forty-Two Point Eight',
    '204.4',
    'One Hundred Eighty-Four Point Two',
    'One Hundred Forty Point Four',
    '12,321',
    '1,234,321',
    'One Hundred Twenty One',
    'One',
    '2.4'
  ];

  List<Map<String, String>> questions = [
    {"Q": '512 / 5', "A": 'One Hundred Two Point Four'},
    {"Q": '214 / 5', "A": 'Forty-Two Point Eight'},
    {"Q": 'One Thousand Twenty Two Divided by Five', "A": '204.4'},
    {"Q": '921 / 5', "A": 'One Hundred Eighty-Four Point Two'},
    {"Q": '702 / 5', "A": 'One Hundred Forty Point Four'},
    {"Q": 'One Hundred Eleven Squared', "A": '12,321'},
    {"Q": 'Eleven Squared', "A": 'One Hundred Twenty One'},
    {"Q": '1111 Squared', "A": '1,234,321'},
    {"Q": 'One Squared', "A": 'One'},
    {"Q": 'Twelve Divided by Five', "A": '2.4'}
  ];

  int currentQuestionIndex = 0;
  int timeRemaining = 200;
  Timer? timer;
  Map<String, bool> disableOption = {};
  Map<String, bool> correctOption = {};

  @override
  void initState() {
    super.initState();
    questions.shuffle();
    bingoWords.shuffle();
    for (String word in bingoWords) {
      disableOption[word] = false;
      correctOption[word] = false;
    }
    startTimer();
    Future.delayed(Duration.zero, () => _showInstructions()); // Show instructions at the start
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(milliseconds: 100), (Timer t) {
      setState(() {
        if (timeRemaining > 0) {
          timeRemaining--;
        } else {
          if (currentQuestionIndex == questions.length - 1) {
            timer?.cancel();
            _showAllQuestionsCompletedDialog();
          }
          timeRemaining = 200;
          currentQuestionIndex = (currentQuestionIndex + 1) % questions.length;
        }
      });
    });
  }

  void handleButtonPress(a) {
    setState(() {
      disableOption[a] = true;
      correctOption[a] = questions[currentQuestionIndex]['A'] as String == a;
      if (currentQuestionIndex == questions.length - 1) {
        timer?.cancel();
        _showAllQuestionsCompletedDialog();
      }
      timeRemaining = 200;
      currentQuestionIndex = (currentQuestionIndex + 1) % questions.length;
    });
  }

  void _showAllQuestionsCompletedDialog() {
    int correctAnswer = 0;
    for (var element in correctOption.values) {
      correctAnswer += element ? 1 : 0;
    }
    score = score + correctAnswer * 5;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("All Questions Completed", style: TextStyle(fontSize: 20)),
          content: Text('You have answered $correctAnswer correctly', style: const TextStyle(fontSize: 30)),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const WelcomeScreen()));
              },
              child: const Text("Close", style: TextStyle(fontSize: 18)),
            ),
          ],
        );
      },
    );
  }

  void _showInstructions() {
    // Define the current language state
    bool isEnglish = true; // Default language is English

    // Define your English and Spanish instructions
    final String englishInstructions =
        'Get ready for a math-filled Bingo challenge! '
        'Your task is simple: solve the math problem at the top and click the correct answer from the bingo board. '
        'Earn points for each correct answer, and make sure you answer before time runs out! '
        'Are you fast enough to solve them all?';

    final String spanishInstructions =
        '¡Prepárate para un desafío de Bingo lleno de matemáticas! '
        'Tu tarea es simple: resuelve el problema matemático en la parte superior y haz clic en la respuesta correcta del tablero de bingo. '
        '¡Gana puntos por cada respuesta correcta y asegúrate de responder antes de que se acabe el tiempo! '
        '¿Eres lo suficientemente rápido para resolverlos todos?';

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Colors.white,
          child: Container(
            padding: const EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.6,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.lightBlue.shade400, // Exact lighter blue
                  Colors.purple.shade200,    // Exact purple color from previous dialog
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 10,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.lightbulb_outline,
                  color: Colors.yellow,
                  size: 60,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Bingo Fun Time!',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: SingleChildScrollView(
                    child: Text(
                      isEnglish ? englishInstructions : spanishInstructions,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white.withOpacity(0.9),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          isEnglish = !isEnglish; // Toggle the language
                        });
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        backgroundColor: Colors.grey.shade300, // Light background for the button
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        isEnglish ? 'Español' : 'English',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 15,
                        ),
                        backgroundColor: Colors.orange, // Same button color as crossword game
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: const Text(
                        'Let\'s Play!',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Color _getColorForProgress(double progress) {
    if (progress < 0.5) {
      return Color.lerp(Colors.red, Colors.yellow, progress * 2)!;
    } else {
      return Color.lerp(Colors.yellow, Colors.green, (progress - 0.5) * 2)!;
    }
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 80),
              Card(
                elevation: 10,
                child: Container(
                  width: 1200,
                  height: 200,
                  color: Colors.white,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Expanded(
                          child: Center(
                            child: Text(
                              questions[currentQuestionIndex]['Q'] as String,
                              style: const TextStyle(fontSize: 48),
                            ),
                          ),
                        ),
                        LinearProgressIndicator(
                          value: timeRemaining / 200,
                          semanticsLabel: 'Linear progress indicator',
                          minHeight: 15,
                          backgroundColor: Colors.grey,
                          valueColor: AlwaysStoppedAnimation<Color>(
                              _getColorForProgress(timeRemaining / 200)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 80),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 40, right: 40),
                  child: Card(
                    elevation: 10,
                    color: const Color(0xFFFFF59D),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          for (int row = 0; row < 5; row++)
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  for (int col = 0; col < 2; col++)
                                    CustomButton(
                                      buttonText: bingoWords[(row * 2) + col],
                                      onPressed: () {
                                        handleButtonPress(bingoWords[(row * 2) + col]);
                                      },
                                      isDisable: disableOption[bingoWords[(row * 2) + col]] ?? false,
                                      isCorrect: correctOption[bingoWords[(row * 2) + col]] ?? false,
                                    ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}
