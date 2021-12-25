import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 38;
  double resultFontSize = 48;

  ButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'c') {
        equation = '0';
        result = '0';
        double equationFontSize = 38;
        double resultFontSize = 48;
      } else if (buttonText == '⌫') {
        double equationFontSize = 38;
        double resultFontSize = 48;
        equation = equation.substring(0, equation.length - 1);
        if (equation == '') {
          equation = '0';
        }
      } else if (buttonText == '=') {
        double equationFontSize = 38;
        double resultFontSize = 48;
        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');
        try {
          Parser p = new Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = new ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = 'Error';
        }
      } else {
        double equationFontSize = 38;
        double resultFontSize = 48;
        if (equation == '0') {
          equation = buttonText;
        } else {
          equation += buttonText;
        }
      }
    });
  }

  Container buildButton(
      {required String buttonText,
      required Color buttonColor,
      required double buttonHeight}) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      child: TextButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsets>(
            const EdgeInsets.all(16),
          ),
          side: MaterialStateProperty.all<BorderSide>(
            const BorderSide(
                color: Colors.white, style: BorderStyle.solid, width: 1),
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
          ),
        ),
        child: Text(
          buttonText,
          style: const TextStyle(
              fontSize: 30, fontWeight: FontWeight.normal, color: Colors.white),
        ),
        onPressed: () => ButtonPressed(buttonText),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Calculator'),
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              equation,
              style: TextStyle(fontSize: equationFontSize),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              result,
              style: TextStyle(fontSize: resultFontSize),
            ),
          ),
          const Expanded(
            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * .75,
                child: Table(
                  children: [
                    TableRow(children: [
                      buildButton(
                          buttonColor: Colors.redAccent,
                          buttonHeight: 1,
                          buttonText: "c"),
                      buildButton(
                          buttonColor: Colors.blue,
                          buttonHeight: 1,
                          buttonText: "⌫"),
                      buildButton(
                          buttonColor: Colors.blue,
                          buttonHeight: 1,
                          buttonText: "÷"),
                    ]),
                    TableRow(children: [
                      buildButton(
                          buttonColor: Colors.black54,
                          buttonHeight: 1,
                          buttonText: "7"),
                      buildButton(
                          buttonColor: Colors.black54,
                          buttonHeight: 1,
                          buttonText: "8"),
                      buildButton(
                          buttonColor: Colors.black54,
                          buttonHeight: 1,
                          buttonText: "9"),
                    ]),
                    TableRow(children: [
                      buildButton(
                          buttonColor: Colors.black54,
                          buttonHeight: 1,
                          buttonText: "4"),
                      buildButton(
                          buttonColor: Colors.black54,
                          buttonHeight: 1,
                          buttonText: "5"),
                      buildButton(
                          buttonColor: Colors.black54,
                          buttonHeight: 1,
                          buttonText: "6"),
                    ]),
                    TableRow(children: [
                      buildButton(
                          buttonColor: Colors.black54,
                          buttonHeight: 1,
                          buttonText: "3"),
                      buildButton(
                          buttonColor: Colors.black54,
                          buttonHeight: 1,
                          buttonText: "2"),
                      buildButton(
                          buttonColor: Colors.black54,
                          buttonHeight: 1,
                          buttonText: "1"),
                    ]),
                    TableRow(children: [
                      buildButton(
                          buttonColor: Colors.black54,
                          buttonHeight: 1,
                          buttonText: "."),
                      buildButton(
                          buttonColor: Colors.black54,
                          buttonHeight: 1,
                          buttonText: "0"),
                      buildButton(
                          buttonColor: Colors.black54,
                          buttonHeight: 1,
                          buttonText: "00"),
                    ])
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(children: [
                      buildButton(
                          buttonColor: Colors.blue,
                          buttonHeight: 1,
                          buttonText: "×"),
                    ]),
                    TableRow(children: [
                      buildButton(
                          buttonColor: Colors.blue,
                          buttonHeight: 1,
                          buttonText: "-"),
                    ]),
                    TableRow(children: [
                      buildButton(
                          buttonColor: Colors.blue,
                          buttonHeight: 1,
                          buttonText: "+"),
                    ]),
                    TableRow(children: [
                      buildButton(
                          buttonColor: Colors.redAccent,
                          buttonHeight: 2,
                          buttonText: "="),
                    ])
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
