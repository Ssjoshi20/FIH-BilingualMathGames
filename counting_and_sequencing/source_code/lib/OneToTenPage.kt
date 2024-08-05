
class OneToTenPage extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: Colors.purple[100],
        appBar: AppBar(
        title: Text('LEVEL 1'),
        centerTitle: true,
        backgroundColor: Colors.purple,
        ),
        body: Center(
        child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
        SizedBox(height: 20),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
        NonClickableNumber(text: 'Two'),
        NonClickableNumber(text: 'Three'),
        NonClickableNumber(text: '______'),
        NonClickableNumber(text: 'Five'),
        ],
        ),
        SizedBox(height: 32),
        Text(
            'Choose an Option',
            style: TextStyle(
                    fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        ),
        ),
        SizedBox(height: 32),
        NumberOptionButton(
            text: 'One',
        onPressed: () => navigate(context, false),
        ),
        NumberOptionButton(
            text: 'Seven',
        onPressed: () => navigate(context, false),
        ),
        NumberOptionButton(
            text: 'Six',
        onPressed: () => navigate(context, false),
        ),
        NumberOptionButton(
            text: 'Four',
        onPressed: () => navigate(context, true),
        ),
        ],
        ),
        ),
        );
    }

    void navigate(BuildContext context, bool isCorrect) {
        if (isCorrect) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => RightAnswerPage(
                    onNextQuestionPressed: () {
                // Navigate to the next question in the sequence
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TwentyThreeToTwentySixPage()),
                );
            },
            ),
            ),
            );
        } else {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WrongAnswerPage()),
            );
        }
    }
}

class TwentyThreeToTwentySixPage extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: Colors.purple[100],
        appBar: AppBar(
        title: Text('LEVEL 1'),
        centerTitle: true,
        backgroundColor: Colors.purple,
        ),
        body: Center(
        child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
        SizedBox(height: 20),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
        NonClickableNumber(text: 'Twenty Three'),
        NonClickableNumber(text: 'Twenty Four'),
        NonClickableNumber(text: 'Twenty Five'),
        NonClickableNumber(text: '____________'),
        ],
        ),
        SizedBox(height: 32),
        Text(
            'Choose an Option',
            style: TextStyle(
                    fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        ),
        ),
        SizedBox(height: 32),
        NumberOptionButton(
            text: 'Twenty Seven',
        onPressed: () => navigate(context, false),
        ),
        NumberOptionButton(
            text: 'Thirty Seven',
        onPressed: () => navigate(context, false),
        ),
        NumberOptionButton(
            text: 'Twenty Six',
        onPressed: () => navigate(context, true),
        ),
        NumberOptionButton(
            text: 'Twenty Two',
        onPressed: () => navigate(context, false),
        ),
        ],
        ),
        ),
        );
    }

    void navigate(BuildContext context, bool isCorrect) {
        if (isCorrect) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => RightAnswerPage(
                    onNextQuestionPressed: () { /*
              // Navigate to the next question in the sequence
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TwentyThreeToTwentySixPage()),
              ); */
            },
            ),
            ),
            );
        } else {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WrongAnswerPage()),
            );
        }

    }
}

class NonClickableNumber extends StatelessWidget {
    final String text;

    NonClickableNumber({required this.text});

    @override
    Widget build(BuildContext context) {
        return Container(
            constraints: BoxConstraints(minWidth: 100),
        alignment: Alignment.center,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
        color: Colors.purple[50],
        border: Border.all(),
        borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
        text,
        style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
        ),
        ),
        );
    }
}

class NumberOptionButton extends StatelessWidget {
    final String text;
    final VoidCallback onPressed;

    NumberOptionButton({required this.text, required this.onPressed});

    @override
    Widget build(BuildContext context) {
        return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
        text,
        style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        ),
        ),
        style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
            if (states.contains(MaterialState.hovered)) {
                return Colors.deepPurpleAccent;
            }
            return Colors.deepPurple;
        },
        ),
        fixedSize: MaterialStateProperty.all(Size(180, 55)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
        ),
        ),
        ),
        ),
        ),
        );
    }
}

class RightAnswerPage extends StatelessWidget {
    final VoidCallback onNextQuestionPressed;

    RightAnswerPage({required this.onNextQuestionPressed});

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                    title: Text('Right Answer'),
        ),
        body: Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Text(
            'Congratulations!',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        Text(
            'You answered correctly.',
            style: TextStyle(fontSize: 20),
        ),
        SizedBox(height: 20),
        ElevatedButton(
            onPressed: onNextQuestionPressed,
            child: Text(
                    'Next Question',
            style: TextStyle(fontSize: 18), // Adjust the font size as needed
        ),
        style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15), // Adjust the padding as needed
        ),
        ),
        ],
        ),
        ),
        );
    }
}


class WrongAnswerPage extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                    title: Text('Wrong Answer'),
        ),
        body: Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Text('Oops! Your answer is incorrect.',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        ElevatedButton(
            onPressed: () {
            Navigator.pop(context);
        },
        child: Text('Try Again',
        style: TextStyle(fontSize: 18),
        ),
        style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15), // Adjust the padding as needed
        ),
        ),
        SizedBox(height: 20),
        ElevatedButton(
            onPressed: () {
            // Implement exit logic
        },
        child: Text('Exit',
        style: TextStyle(fontSize: 18),
        ),
        style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15), // Adjust the padding as needed
        ),
        ),
        ],
        ),
        ),
        );
    }
}