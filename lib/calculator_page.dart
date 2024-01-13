import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';


class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String _output = "0";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 32.0,left: 16.0),
              alignment: Alignment.bottomLeft,
              color: Colors.black,
              child: const Text(
                "Creator Sanjarbek",
                style: TextStyle(fontSize: 16.0, color: Colors.red),
              ),
            ),
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16.0),
                  alignment: Alignment.bottomRight,
                  color: Colors.black,
                  child: Text(
                    _output,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 72.0,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  color: Colors.black,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          buildButtonRow(Colors.grey, Colors.black, 'AC', () {}),
                          buildButtonRow(Colors.grey, Colors.black, '+/-', () {}),
                          buildButtonRow(Colors.grey, Colors.black, '%', () {}),
                          buildButtonRow(
                              Colors.amber.shade800, Colors.white, '/', () {}),
                        ],
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          buildButtonRow(
                              Colors.grey.shade900, Colors.white, '7', () {}),
                          buildButtonRow(
                              Colors.grey.shade900, Colors.white, '8', () {}),
                          buildButtonRow(
                              Colors.grey.shade900, Colors.white, '9', () {}),
                          buildButtonRow(
                              Colors.amber.shade800, Colors.white, '*', () {}),
                        ],
                      ),
                      const SizedBox(height: 16.0,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          buildButtonRow(
                              Colors.grey.shade900, Colors.white, '4', () {}),
                          buildButtonRow(
                              Colors.grey.shade900, Colors.white, '5', () {}),
                          buildButtonRow(
                              Colors.grey.shade900, Colors.white, '6', () {}),
                          buildButtonRow(
                              Colors.amber.shade800, Colors.white, '-', () {}),
                        ],
                      ),
                      const SizedBox(height: 16.0,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          buildButtonRow(
                              Colors.grey.shade900, Colors.white, '1', () {}),
                          buildButtonRow(
                              Colors.grey.shade900, Colors.white, '2', () {}),
                          buildButtonRow(
                              Colors.grey.shade900, Colors.white, '3', () {}),
                          buildButtonRow(
                              Colors.amber.shade800, Colors.white, '+', () {}),
                        ],
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () => buttonPressed('0'),
                            child: Container(
                                padding: const EdgeInsets.only(left: 32.0),
                                alignment: Alignment.centerLeft,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.45,
                                height: 80.0,
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade900,
                                    borderRadius: BorderRadius.circular(40.0)
                                ),
                                child: const Text(
                                  '0',
                                  style: TextStyle(
                                      fontSize: 40.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                )),
                          ),
                          buildButtonRow(
                              Colors.grey.shade900, Colors.white, '.', () {}),
                          buildButtonRow(
                              Colors.amber.shade800, Colors.white, '=', () {}),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }


  Widget buildButtonRow(Color color, Color textColor, String text,
      Function function) {
    return GestureDetector(
      onTap: () => buttonPressed(text),
      onLongPress: () => buttonLongPress(text),
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width*0.20,
        height: MediaQuery.of(context).size.height*0.10,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width*0.10),
        ),
        child: Text(
          text,
          style: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
              color: textColor),
        ),
      ),
    );
  }

  void buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == '+/-') {
        double minus = double.parse(_output);
        minus = minus * -1;
        String result = minus.toString();
        _output = result;
      } else if (buttonText == '%') {
        double minus = double.parse(_output);
        minus = minus * (1 / 100);
        String result = minus.toString();
        _output = result;
      } else if (buttonText == '=') {
        _output = _calculateResult(_output);
      } else if (buttonText == 'AC') {
        if (_output.length > 1) {
          _output = _output.substring(0, _output.length - 1);
        } else {
          _output = "0";
        }
      } else {
        if (_output == '0') {
          _output = buttonText;
        } else {
          _output += buttonText;
        }
      }
    });
  }

  void buttonLongPress(String buttonText) {
    setState(() {
      if (buttonText == 'AC') {
        _output = '0';
      }
    });
  }

  String _calculateResult(String output) {
    String result;
    try {
      // Evaluate the mathematical expression using the 'math_expressions' package

      Parser p = Parser();
      Expression exp = p.parse(output);
      ContextModel cm = ContextModel();
      result = '${exp.evaluate(EvaluationType.REAL, cm)}';
    } catch (e) {
      result = 'Error';
    }

    return result;
  }
}
