import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import '../my_home/components/gradient_app_bar.dart';

class MathCraftScreen extends StatefulWidget {
  const MathCraftScreen({Key? key}) : super(key: key);

  @override
  _MathCraftScreenState createState() => _MathCraftScreenState();
}

class _MathCraftScreenState extends State<MathCraftScreen> {
  String craftedValue = "";
  double currentValue = 0.0; // Store the result of the current calculation
  bool isCalculated = false;
  String calculatedBlock = ""; // New block for the calculated value

  final List<String> numbers = ["1", "2", "10"];
  final List<String> operations = ["+", "-", "*"];
  final int targetValue = 123;
  final String hint = "Hint: Use Rule 3: Square of 1's";

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () => _showInstructions()); // Show instructions when the screen loads
  }

  void craft(String value) {
    setState(() {
      if (isCalculated) {
        craftedValue = value; // Start a new expression after calculating
        isCalculated = false;
      } else {
        craftedValue += value;
      }
    });
  }

  void clearCraftingArea() {
    setState(() {
      craftedValue = "";
      currentValue = 0;
      calculatedBlock = ""; // Clear the calculated block
      isCalculated = false;
    });
  }

  bool checkIfCorrect() {
    try {
      Parser p = Parser();
      Expression exp = p.parse(craftedValue);
      ContextModel cm = ContextModel();
      double result = exp.evaluate(EvaluationType.REAL, cm);

      return result == targetValue;
    } catch (e) {
      return false;
    }
  }

  void calculateValue() {
    try {
      Parser p = Parser();
      Expression exp = p.parse(craftedValue);
      ContextModel cm = ContextModel();
      double result = exp.evaluate(EvaluationType.REAL, cm);

      setState(() {
        currentValue = result;
        calculatedBlock = result.toString(); // Update the calculated block
        craftedValue = result.toString();
        isCalculated = true; // Mark as calculated to start a new expression
      });
    } catch (e) {
      setState(() {
        craftedValue = "Error";
      });
    }
  }

  void submitCraftedValue() {
    if (checkIfCorrect()) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Congratulations!'),
          content: const Text('You have crafted the correct number!'),
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
          content: const Text('The crafted number is incorrect.'),
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

  void _showInstructions() {
    // Define the current language state
    bool isEnglish = true; // Default language is English

    // Define your English and Spanish instructions
    final String englishInstructions =
        'Use the available number and operation blocks to craft the target number.\n\n'
        'You can drag and drop numbers or operations into the crafting area. '
        'To simplify complex calculations, use the "Calculate" button, which will store the current value and let you continue crafting.\n\n'
        'Your goal is to reach the number 123 using as few operations as possible.';

    final String spanishInstructions =
        'Utiliza los bloques de números y operaciones disponibles para crear el número objetivo.\n\n'
        'Puedes arrastrar y soltar números u operaciones en el área de creación. '
        'Para simplificar cálculos complejos, utiliza el botón "Calcular", que almacenará el valor actual y te permitirá seguir creando.\n\n'
        'Tu objetivo es alcanzar el número 123 utilizando la menor cantidad de operaciones posible.';

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
                  Colors.purple.shade200,    // Same purple color
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
                  'How to Play Math Craft',
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
                        backgroundColor: Colors.orange, // Vibrant orange for the button
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Craft the Number: 123',
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              hint,
              style: const TextStyle(
                fontSize: 25,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            DragTarget<String>(
              onAccept: (data) {
                craft(data);
              },
              builder: (context, candidateData, rejectedData) {
                return Container(
                  padding: const EdgeInsets.all(16.0),
                  color: Colors.white,
                  height: 80,
                  width: 300,
                  child: Center(
                    child: Text(
                      craftedValue.isEmpty ? "Drag blocks here" : craftedValue,
                      style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: clearCraftingArea,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade700,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(150, 60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 5,
                  ),
                  child: const Text('Clear', style: TextStyle(fontSize: 28)),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: calculateValue,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(150, 60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 5,
                  ),
                  child: const Text('Calculate', style: TextStyle(fontSize: 28)),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Number Blocks',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...numbers.map((number) {
                  return Draggable<String>(
                    data: number,
                    feedback: Material(
                      color: Colors.transparent,
                      child: _buildBlock(number),
                    ),
                    childWhenDragging: _buildBlock(number, isDragging: true),
                    child: _buildBlock(number),
                  );
                }).toList(),
                if (calculatedBlock.isNotEmpty)
                  Draggable<String>(
                    data: calculatedBlock,
                    feedback: Material(
                      color: Colors.transparent,
                      child: _buildBlock(calculatedBlock),
                    ),
                    childWhenDragging:
                    _buildBlock(calculatedBlock, isDragging: true),
                    child: _buildBlock(calculatedBlock),
                  ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Operation Blocks',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: operations.map((operation) {
                return Draggable<String>(
                  data: operation,
                  feedback: Material(
                    color: Colors.transparent,
                    child: _buildBlock(operation),
                  ),
                  childWhenDragging: _buildBlock(operation, isDragging: true),
                  child: _buildBlock(operation),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: submitCraftedValue,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                minimumSize: const Size(200, 60),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 5,
              ),
              child: const Text('Submit', style: TextStyle(fontSize: 28)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBlock(String value, {bool isDragging = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: isDragging ? Colors.grey : Colors.blueAccent,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(
        value,
        style: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
