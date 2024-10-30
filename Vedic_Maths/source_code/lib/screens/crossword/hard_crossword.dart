import 'dart:math';
import 'package:crossword/crossword.dart';
import 'package:flutter/material.dart';
import '../my_home/components/gradient_app_bar.dart';
import '../welcome/play.dart';
import 'package:vedicmath/global.dart';

class HardCrosswordScreen extends StatefulWidget {
  const HardCrosswordScreen({Key? key}) : super(key: key);

  @override
  State<HardCrosswordScreen> createState() => _HardCrosswordScreenState();
}

class _HardCrosswordScreenState extends State<HardCrosswordScreen> {
  List<Color> lineColors = [];
  String word = "";
  Set<String> selectedWords = {};
  List<String> selectedSequence = [];
  int clearCounter = 0;

  // Hard difficulty questions based on Vedic math rules, ensuring answers fit within the 9x9 grid
  final List<String> questions = [
    "111 squared",           // Square of numbers made of 1
    "1111 squared",          // Square of numbers made of 1
    "14 * 17",               // Multiplication of two numbers between 10-20
    "18 * 19",               // Multiplication of two numbers between 10-20
    "125 divided by 5",      // Division by 5
    "145 divided by 5",      // Division by 5
    "97 squared",            // Square of numbers near 100
    "103 squared",           // Square of numbers near 100
    "75 squared",            // Square of numbers ending with 5
    "95 squared",            // Square of numbers ending with 5
  ];

  final List<String> answers = [
    "12321",                 // 111 squared
    "1234321",               // 1111 squared
    "238",                   // 14 * 17
    "342",                   // 18 * 19
    "25",                    // 125 divided by 5
    "29",                    // 145 divided by 5
    "9409",                  // 97 squared
    "10609",                 // 103 squared
    "5625",                  // 75 squared
    "9025",                  // 95 squared
  ];

  List<String> selectedQuestions = [];
  List<String> selectedAnswers = [];

  List<Color> generateRandomColors() {
    Random random = Random();
    return List.generate(
      100,
          (_) => Color.fromARGB(
        255,
        128 + random.nextInt(128),
        128 + random.nextInt(128),
        128 + random.nextInt(128),
      ),
    );
  }

  void selectRandomQuestionsAndAnswers() {
    final random = Random();
    final selectedIndices = <int>{};
    while (selectedIndices.length < 10) { // Select 10 questions for hard level
      selectedIndices.add(random.nextInt(questions.length));
    }
    selectedQuestions = selectedIndices.map((index) => questions[index]).toList();
    selectedAnswers = selectedIndices.map((index) => answers[index]).toList();
  }

  bool canPlaceWord(String answer, List<List<String>> grid, int row, int col, bool horizontal) {
    if (horizontal) {
      if (col + answer.length > 9) return false; // Out of bounds
      for (int i = 0; i < answer.length; i++) {
        if (grid[row][col + i] != "" && grid[row][col + i] != answer[i]) {
          return false; // Conflict with existing word
        }
      }
    } else {
      if (row + answer.length > 9) return false; // Out of bounds
      for (int i = 0; i < answer.length; i++) {
        if (grid[row + i][col] != "" && grid[row + i][col] != answer[i]) {
          return false; // Conflict with existing word
        }
      }
    }
    return true;
  }

  void placeWord(String answer, List<List<String>> grid, int row, int col, bool horizontal) {
    if (horizontal) {
      for (int i = 0; i < answer.length; i++) {
        grid[row][col + i] = answer[i];
      }
    } else {
      for (int i = 0; i < answer.length; i++) {
        grid[row + i][col] = answer[i];
      }
    }
  }

  List<List<String>> generateCrossword() {
    List<List<String>> grid = List.generate(9, (_) => List.generate(9, (_) => ""));
    final random = Random();

    for (String answer in selectedAnswers) {
      bool placed = false;
      int attempts = 0;

      while (!placed && attempts < 100) { // Limit attempts to avoid infinite loop
        int row = random.nextInt(9);
        int col = random.nextInt(9);
        bool horizontal = random.nextBool();

        if (canPlaceWord(answer, grid, row, col, horizontal)) {
          placeWord(answer, grid, row, col, horizontal);
          placed = true;
        }
        attempts++;
      }

      if (!placed) {
        throw Exception("Unable to place word: $answer");
      }
    }

    // Fill the remaining empty spaces with random numbers to complete the grid
    for (int row = 0; row < 9; row++) {
      for (int col = 0; col < 9; col++) {
        if (grid[row][col] == "") {
          grid[row][col] = (random.nextInt(9) + 1).toString();
        }
      }
    }

    return grid;
  }

  @override
  void initState() {
    super.initState();
    selectRandomQuestionsAndAnswers();
    lineColors = generateRandomColors();
    Future.delayed(Duration.zero, () => _showInstructions());
  }

  GlobalKey<CrosswordState> crosswordState = GlobalKey<CrosswordState>();

  void checkAnswers() {
    bool allCorrect = true;
    for (String answer in selectedSequence) {
      if (!selectedAnswers.contains(answer)) {
        allCorrect = false;
        break;
      }
    }

    if (allCorrect) {
      setState(() {
        score += selectedSequence.length * 10;
      });
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Congratulations!'),
          content: const Text('You have completed the crossword puzzle.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Try Again!'),
          content: const Text('Some selections are incorrect.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        ),
      );
    }
  }

  void clearSelections() {
    setState(() {
      selectedWords.clear();
      selectedSequence.clear();
      clearCounter++;
    });
  }

  void _showInstructions() {
    bool isEnglish = true;

    final String englishInstructions =
        'Drag your finger across the crossword to form words corresponding to the hints provided. '
        'Try to find all the correct words to complete the crossword and score points! \n\n'
        'Each correct word will fill in the crossword puzzle, and you will earn points for each correct entry. '
        'Clear the board and aim for the highest score!';

    final String spanishInstructions =
        'Deslice su dedo por el crucigrama para formar palabras que correspondan a las pistas proporcionadas. '
        '¡Intenta encontrar todas las palabras correctas para completar el crucigrama y ganar puntos! \n\n'
        'Cada palabra correcta llenará el crucigrama, y ganarás puntos por cada entrada correcta. '
        '¡Limpia el tablero y apunta a la puntuación más alta!';

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
                  Colors.lightBlue.shade400,
                  Colors.purple.shade200,
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
                  'How to Play',
                  style: TextStyle(
                    fontSize: 34,
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
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
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
                          isEnglish = !isEnglish;
                        });
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        backgroundColor: Colors.grey.shade300,
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
                        backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: const Text(
                        'Start Game',
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
    final grid = generateCrossword();
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
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const PlayScreen()),
                    );
                  },
                ),
                Expanded(
                  child: Center(
                    child: Text(word, style: const TextStyle(fontSize: 20, color: Colors.white)),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: clearSelections,
                  color: Colors.white,
                ),
              ],
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Crossword(
                      key: ValueKey(clearCounter),
                      revealLetterDecoration: const RevealLetterDecoration(
                        shakeOffset: Offset(10, 20),
                      ),
                      allowOverlap: true,
                      letters: grid,
                      spacing: const Offset(80, 80),
                      onLineDrawn: (List<String> words) {
                        setState(() {
                          selectedWords.addAll(words);
                          selectedSequence = words;
                          word = words.join(" ");
                        });
                      },
                      onLineUpdate: (String word) {
                        setState(() {
                          this.word = word;
                        });
                      },
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                      lineDecoration: const LineDecoration(
                        lineGradientColors: [
                          [Colors.purple],
                        ],
                        strokeWidth: 26,
                        lineTextStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      hints: selectedAnswers,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Hints',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 10),
                          for (var question in selectedQuestions)
                            Text(
                              question,
                              style: const TextStyle(
                                  fontSize: 28, color: Colors.white),
                            ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: checkAnswers,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                minimumSize: const Size(200, 60),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 5,
              ),
              child: const Text('Check Answers', style: TextStyle(fontSize: 20)),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}