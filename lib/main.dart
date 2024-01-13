import 'package:flutter/material.dart';
import 'package:kalkulyator/calculator_page.dart';

void main() => runApp(const Calculator());

class Calculator extends StatelessWidget {
  const Calculator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kalkulyator',
      theme: ThemeData(
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
            .copyWith(secondary: Colors.blueGrey[900]),
      ),
      home: const CalculatorPage(),
    );
  }
}
