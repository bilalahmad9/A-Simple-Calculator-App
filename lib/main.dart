import 'package:calculator/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/text.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  var UserQuestion = '';
  var UserAnswer = '';

  final List<String> buttons = [
    'C',
    'DEL',
    '%',
    '/',
    '9',
    '8',
    '7',
    'X',
    '6',
    '5',
    '4',
    '-',
    '3',
    '2',
    '1',
    '+',
    '0',
    '.',
    'ANS',
    '=',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      UserAnswer,
                      style:
                          TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.centerRight,
                    child: Text(
                      UserQuestion,
                      style:
                          TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: GridView.builder(
                itemCount: buttons.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemBuilder: (BuildContext context, int index) {
                  // Clear Button

                  if (index == 0) {
                    return MyButton(
                      ButtonTapped: () {
                        setState(() {
                          UserQuestion = '';
                          UserAnswer = '0';
                        });
                      },
                      ButtonText: buttons[index],
                      color: Colors.green,
                      TextColor: Colors.white,
                    );
                  }

                  // Delete Button

                  else if (index == 1) {
                    return MyButton(
                      ButtonTapped: () {
                        setState(() {
                          UserQuestion = UserQuestion.substring(
                              0, UserQuestion.length - 1);
                        });
                      },
                      ButtonText: buttons[index],
                      color: Colors.red,
                      TextColor: Colors.white,
                    );
                  }

                  // Equal Button
                  else if (index == buttons.length - 1) {
                    return MyButton(
                      ButtonTapped: () {
                        setState(() {
                          EqualPressed();
                        });
                      },
                      ButtonText: buttons[index],
                      color: Colors.deepOrange,
                      TextColor: Colors.white,
                    );
                  }

                  //Reset of the Buttons

                  else {
                    return MyButton(
                      ButtonTapped: () {
                        setState(() {
                          UserQuestion += buttons[index];
                        });
                      },
                      ButtonText: buttons[index],
                      color: isOperator(buttons[index])
                          ? Colors.deepOrange
                          : Colors.deepPurple[50],
                      TextColor: isOperator(buttons[index])
                          ? Colors.white
                          : Colors.deepPurple,
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool isOperator(String x) {
    if (x == '%' ||
        x == '/' ||
        x == 'X' ||
        x == '-' ||
        x == '+' ||
        x == '=') {
      return true;
    }
    return false;
  }

  void EqualPressed() {

    String finalQuestion = UserQuestion;
    finalQuestion = finalQuestion.replaceAll('X', '*');

    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    UserAnswer = eval.toString();
  }
}
