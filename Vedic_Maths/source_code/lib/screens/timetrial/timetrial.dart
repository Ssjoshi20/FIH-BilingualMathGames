import 'dart:math';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vedicmath/screens/timetrial/components/gradient_app_bar.dart';
import 'package:vedicmath/screens/welcome/welcome_screen.dart';
import 'package:vedicmath/global.dart';

class TimeTrialWidget extends StatefulWidget {
  const TimeTrialWidget({Key? key}) : super(key: key);

  @override
  _TimeTrialWidgetState createState() => _TimeTrialWidgetState();
}

class _TimeTrialWidgetState extends State<TimeTrialWidget> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _dinosaurAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: Duration(seconds: timeRemaining),
      vsync: this,
    );

    _dinosaurAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });

    startTimer();
    _animationController.forward();
    Future.delayed(Duration.zero, () => _showInstructions()); // Show instructions when the screen loads
  }

  @override
  void dispose() {
    _animationController.dispose();
    timer?.cancel();
    super.dispose();
  }

  final List<Map<String, Object>> _question = [
    {
      'questionText': 'What is the square of 12?',
      'options': ['144', '132', '156', '168'],
      'correctAnswer': '144',
    },
    {
      'questionText': 'What is 23 multiplied by 17?',
      'options': ['391', '408', '391', '437'],
      'correctAnswer': '391',
    },
    {
      'questionText': 'What is 78 divided by 6?',
      'options': ['12', '13', '14', '15'],
      'correctAnswer': '13',
    },
    {
      'questionText': 'What is the product of 9 and 11?',
      'options': ['99', '91', '100', '101'],
      'correctAnswer': '99',
    },
    {
      'questionText': 'What is 5 squared?',
      'options': ['25', '20', '30', '35'],
      'correctAnswer': '25',
    },
    {
      'questionText': 'What is 15 plus 27?',
      'options': ['42', '40', '38', '45'],
      'correctAnswer': '42',
    },
    {
      'questionText': 'What is the square root of 81?',
      'options': ['8', '7', '9', '10'],
      'correctAnswer': '9',
    },
    {
      'questionText': 'What is 64 divided by 8?',
      'options': ['8', '7', '9', '10'],
      'correctAnswer': '8',
    },
    {
      'questionText': 'What is 20 percent of 50?',
      'options': ['10', '15', '20', '25'],
      'correctAnswer': '10',
    },
    {
      'questionText': 'What is 15 times 4?',
      'options': ['60', '65', '70', '75'],
      'correctAnswer': '60',
    },
  ];

  String? _selectedAnswer;
  int _currentQuesNo = Random().nextInt(9);
  int _correctCount = 0;
  int timeRemaining = 10;
  Timer? timer;

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {
        if (timeRemaining > 0) {
          timeRemaining--;
        } else {
          timer?.cancel();
          _animationController.stop();
          _showAllQuestionsCompletedDialog();
        }
      });
    });
  }

  void _giveTimeBonus() {
    setState(() {
      timeRemaining += 2;

      double secondsAdded = 2;
      double totalDuration = _animationController.duration!.inSeconds.toDouble();
      double moveBackAmount = secondsAdded / totalDuration;

      double currentAnimationValue = _animationController.value;
      double newValue = currentAnimationValue - moveBackAmount;
      if (newValue < 0.0) newValue = 0.0;

      _animationController.duration = Duration(seconds: timeRemaining);
      _animationController.value = newValue;
      _animationController.forward();
    });
  }

  Color _getColorForProgress(double progress) {
    if (progress < 0.5) {
      return Color.lerp(Colors.red, Colors.yellow, progress * 2)!;
    } else {
      return Color.lerp(Colors.yellow, Colors.green, (progress - 0.5) * 2)!;
    }
  }

  void _answerQuestion(int index) {
    setState(() {
      _selectedAnswer = (_question[_currentQuesNo]["options"] as List)[index];
    });
  }

  void _submitAnswer() {
    String correctAnswer = _question[_currentQuesNo]['correctAnswer'] as String;
    setState(() {
      if (_selectedAnswer == correctAnswer) {
        _correctCount += 1;
        _giveTimeBonus();
      }
      _currentQuesNo = Random().nextInt(_question.length);
      _selectedAnswer = null;
    });
  }

  void _showAllQuestionsCompletedDialog() {
    score = score + _correctCount * 5;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Time Up!", style: TextStyle(fontSize: 20)),
          content: Text('You have answered $_correctCount correctly',
              style: const TextStyle(fontSize: 30)),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const WelcomeScreen()));
              },
              child: const Text("Close", style: TextStyle(fontSize: 18)),
            ),
          ],
        );
      },
    );
  }

  // The method that was missing
  Color? _getBackgroundColor(int index) {
    String option = (_question[_currentQuesNo]["options"] as List)[index];
    if (_selectedAnswer == option) {
      return Colors.yellow; // Highlight selected answer with yellow
    }
    return null; // Return null for default background
  }

  // The method that was missing
  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes : $twoDigitSeconds";
  }

  void _showInstructions() {
    // Define the current language state
    bool isEnglish = true; // Default language is English

    // Define your English and Spanish instructions
    final String englishInstructions =
        'In this time-based challenge, answer as many math questions as you can before the timer runs out! '
        'Each correct answer will give you a time bonus to keep playing. '
        'Select the correct answer from the given options and hit "Submit" to move to the next question. '
        'Can you beat the clock?';

    final String spanishInstructions =
        '¡En este desafío basado en el tiempo, responde tantas preguntas de matemáticas como puedas antes de que se acabe el tiempo! '
        'Cada respuesta correcta te dará un bono de tiempo para seguir jugando. '
        'Selecciona la respuesta correcta de las opciones dadas y presiona "Enviar" para pasar a la siguiente pregunta. '
        '¿Puedes vencer el reloj?';

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
                  Colors.lightBlue.shade400, // Same lighter blue
                  Colors.purple.shade200,    // Same purple color from previous dialogs
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
                  'Time Trial Challenge!',
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
                        'Start Time Trial',
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


  @override
  Widget build(BuildContext context) {
    double dinosaurSize = 120.0;
    double manSize = 120.0;
    double startingOffset = MediaQuery.of(context).size.width * 0.15;
    double endingOffset = MediaQuery.of(context).size.width * 0.85;

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
      body: Stack(
        children: <Widget>[
          Container(
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
          ),
          Positioned.fill(
            child: CustomPaint(
              painter: PathPainter(_dinosaurAnimation.value, startingOffset, endingOffset),
            ),
          ),
          Positioned(
            left: startingOffset + _dinosaurAnimation.value * (endingOffset - startingOffset),
            bottom: 50.0,
            child: SvgPicture.asset(
              'assets/dinosaur.svg',
              width: dinosaurSize,
            ),
          ),
          Positioned(
            left: endingOffset,
            bottom: 50.0,
            child: SvgPicture.asset(
              'assets/running_man.svg',
              width: manSize,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              QuestionText(
                questionText: _question[_currentQuesNo]['questionText'] as String,
              ),
              Container(
                padding: const EdgeInsets.only(left: 200, right: 200, top: 75, bottom: 75),
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 5,
                    mainAxisSpacing: 40.0,
                    crossAxisSpacing: 100.0,
                  ),
                  itemCount: (_question[_currentQuesNo]['options'] as List).length,
                  itemBuilder: (context, index) {
                    return ElevatedButton(
                      onPressed: () => _answerQuestion(index),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _getBackgroundColor(index),
                      ),
                      child: Text(
                        (_question[_currentQuesNo]["options"] as List)[index],
                        style: const TextStyle(fontSize: 30, color: Colors.black),
                      ),
                    );
                  },
                ),
              ),
              ElevatedButton(
                onPressed: _selectedAnswer == null ? null : _submitAnswer,
                child: const Text('Submit', style: TextStyle(fontSize: 28)),
              ),
            ],
          ),
          Positioned(
            right: 30.0,
            top: 30.0,
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        _printDuration(Duration(seconds: timeRemaining)),
                        style: TextStyle(
                            fontSize: 40,
                            color: _getColorForProgress(timeRemaining / 60)),
                      ),
                      Text(
                        'Correct Answer: $_correctCount',
                        style: const TextStyle(
                          fontSize: 40,
                          color: Colors.blueGrey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class QuestionText extends StatelessWidget {
  final String questionText;
  const QuestionText({Key? key, required this.questionText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.white))),
      child: Text(
        questionText,
        style: const TextStyle(
            fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white),
        textAlign: TextAlign.left,
      ),
    );
  }
}

class PathPainter extends CustomPainter {
  final double dinosaurPosition;
  final double startX;
  final double endX;

  PathPainter(this.dinosaurPosition, this.startX, this.endX);

  @override
  void paint(Canvas canvas, Size size) {
    double y = size.height - 80.0;

    var paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    var dashWidth = 10.0;
    var dashSpace = 10.0;
    double distance = 0.0;

    while (distance < endX - startX) {
      canvas.drawLine(
          Offset(startX + distance, y),
          Offset(startX + distance + dashWidth, y),
          paint);
      distance += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
