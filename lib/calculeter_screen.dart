import 'package:flutter/material.dart';
import 'calbutton_class.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String display = '';
  String result = '';

  void buttonPressed(String value) {
    setState(() {
      if (value == 'C') {
        display = '';
        result = '';
      } else if (value == '=') {
        try {
          result = _calculate(display);
        } catch (e) {
          result = 'Error';
        }
      } else {
        display += value;
      }
    });
  }

  String _calculate(String exp) {
    try {
      exp = exp.replaceAll('×', '*').replaceAll('÷', '/');
      final res = _evaluate(exp);
      return res.toString();
    } catch (e) {
      return 'Error';
    }
  }

  double _evaluate(String exp) {
    List<String> tokens =
    exp.split(RegExp(r'([+\-*/])')).where((e) => e.isNotEmpty).toList();
    List<String> ops =
    exp.split(RegExp(r'[^+\-*/]')).where((e) => e.isNotEmpty).toList();

    double current = double.parse(tokens[0]);
    for (int i = 0; i < ops.length; i++) {
      double next = double.parse(tokens[i + 1]);
      switch (ops[i]) {
        case '+':
          current += next;
          break;
        case '-':
          current -= next;
          break;
        case '*':
          current *= next;
          break;
        case '/':
          current /= next;
          break;
      }
    }
    return current;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Display Area
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Text(
                display,
                style: const TextStyle(color: Colors.white, fontSize: 38),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                result,
                style: const TextStyle(color: Colors.greenAccent, fontSize: 28),
              ),
            ),
            const SizedBox(height: 10),

            // Buttons Area
            Column(
              children: [
                Row(
                  children: [
                    CalcButton(text: '7', onTap: buttonPressed),
                    CalcButton(text: '8', onTap: buttonPressed),
                    CalcButton(text: '9', onTap: buttonPressed),
                    CalcButton(text: '÷', onTap: buttonPressed, color: Colors.orange),
                  ],
                ),
                Row(
                  children: [
                    CalcButton(text: '4', onTap: buttonPressed),
                    CalcButton(text: '5', onTap: buttonPressed),
                    CalcButton(text: '6', onTap: buttonPressed),
                    CalcButton(text: '×', onTap: buttonPressed, color: Colors.orange),
                  ],
                ),
                Row(
                  children: [
                    CalcButton(text: '1', onTap: buttonPressed),
                    CalcButton(text: '2', onTap: buttonPressed),
                    CalcButton(text: '3', onTap: buttonPressed),
                    CalcButton(text: '-', onTap: buttonPressed, color: Colors.orange),
                  ],
                ),
                Row(
                  children: [
                    CalcButton(text: 'C', onTap: buttonPressed, color: Colors.redAccent),
                    CalcButton(text: '0', onTap: buttonPressed),
                    CalcButton(text: '=', onTap: buttonPressed, color: Colors.green),
                    CalcButton(text: '+', onTap: buttonPressed, color: Colors.orange),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
