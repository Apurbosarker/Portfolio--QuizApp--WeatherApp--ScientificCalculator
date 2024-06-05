import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'dart:math' as math;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Scientific Calculator',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const CalculatorScreen(),
    );
  }
}

enum LengthUnit { meter, kilometer, mile, foot, inch }

enum WeightUnit { gram, kilogram, pound, ounce }

enum TemperatureUnit { celsius, fahrenheit, kelvin }

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _display = '';
  final List<String> _history = [];

  final List<String> _buttonValues = [
    'sqrt',
    'sin',
    'cos',
    'tan',
    'sec',
    'csc',
    'log',
    'exp',
    'x!',
    'ln',
    'log10',
    'sin^-1',
    'cos^-1',
    'tan^-1',
    '%',
    '7',
    '8',
    '9',
    "DEL",
    'AC',
    '4',
    '5',
    '6',
    '*',
    '/',
    '1',
    '2',
    '3',
    '+',
    '-',
    '0',
    '.',
    '=',
    'm to km', // Length conversion
    'km to m', // Length conversion
    'g to kg', // Weight conversion
    'kg to g', // Weight conversion
    'C to F', // Temperature conversion
    'F to C'
  ];

  void _onButtonPressed(String value) {
    setState(() {
      if (value == 'AC') {
        _display = '';
      } else if (value == 'DEL') {
        if (_display.isNotEmpty) {
          _display = _display.substring(0, _display.length - 1);
        }
      } else if (value == '=') {
        String result = performCalculation();
        _history.add('$_display = $result');
        _display = result;
      } else if (value == 'sqrt') {
        _display = (math.sqrt(double.parse(_display))).toString();
      } else if (value == 'sin') {
        _display = (math.sin(double.parse(_display))).toString();
      } else if (value == 'cos') {
        _display = (math.cos(double.parse(_display))).toString();
      } else if (value == 'tan') {
        _display = (math.tan(double.parse(_display))).toString();
      } else if (value == 'sec') {
        _display = (1 / math.cos(double.parse(_display))).toString();
      } else if (value == 'csc') {
        _display = (1 / math.sin(double.parse(_display))).toString();
      } else if (value == 'log') {
        _display = performLogarithm(double.parse(_display));
      } else if (value == 'exp') {
        _display = (math.exp(double.parse(_display))).toString();
      } else if (value == 'x!') {
        _display = calculateFactorial(double.parse(_display));
      } else if (value == 'ln') {
        _display = (math.log(double.parse(_display))).toString();
      } else if (value == 'log10') {
        _display = (math.log(double.parse(_display)) / math.ln10).toString();
      } else if (value == 'sin^-1') {
        _display = (math.asin(double.parse(_display))).toString();
      } else if (value == 'cos^-1') {
        _display = (math.acos(double.parse(_display))).toString();
      } else if (value == 'tan^-1') {
        _display = (math.atan(double.parse(_display))).toString();
      } else if (value == '%') {
        _display = performModulus();
      } else if (value == 'm to km') {
        _display = convertLength(
                double.parse(_display), LengthUnit.meter, LengthUnit.kilometer)
            .toString();
      } else if (value == 'km to m') {
        _display = convertLength(
                double.parse(_display), LengthUnit.kilometer, LengthUnit.meter)
            .toString();
      } else if (value == 'g to kg') {
        _display = convertWeight(
                double.parse(_display), WeightUnit.gram, WeightUnit.kilogram)
            .toString();
      } else if (value == 'kg to g') {
        _display = convertWeight(
                double.parse(_display), WeightUnit.kilogram, WeightUnit.gram)
            .toString();
      } else if (value == 'C to F') {
        _display = convertTemperature(double.parse(_display),
                TemperatureUnit.celsius, TemperatureUnit.fahrenheit)
            .toString();
      } else if (value == 'F to C') {
        _display = convertTemperature(double.parse(_display),
                TemperatureUnit.fahrenheit, TemperatureUnit.celsius)
            .toString();
      } else {
        _display += value;
      }
    });
  }

  String performModulus() {
    try {
      var operands = _display.split('%');
      if (operands.length >= 2) {
        double dividend = double.parse(operands[0]);
        double divisor = double.parse(operands[1]);
        double result = dividend % divisor;
        return result.toString();
      } else {
        return "Error: Insufficient operands for modulus operation";
      }
    } catch (e) {
      return "Error: Invalid modulus operation";
    }
  }

  String performLogarithm(double number) {
    return math.log(number).toString();
  }

  String calculateFactorial(double number) {
    if (number < 0) {
      return "Error: Factorial is not defined for negative numbers.";
    }
    int factorial = 1;
    for (int i = 1; i <= number.toInt(); i++) {
      factorial *= i;
    }
    return factorial.toString();
  }

  String performCalculation() {
    try {
      Parser p = Parser();
      Expression exp = p.parse(_display);
      ContextModel cm = ContextModel();
      double result = exp.evaluate(EvaluationType.REAL, cm);
      return result.toString();
    } catch (e) {
      return "Error during calculation: $e";
    }
  }

  double convertLength(double value, LengthUnit from, LengthUnit to) {
    const conversions = {
      LengthUnit.meter: {
        LengthUnit.meter: 1,
        LengthUnit.kilometer: 0.001,
        // Add other conversions
      },
      // Add conversions for other units
    };

    return value * conversions[from]![to]!;
  }

  double convertWeight(double value, WeightUnit from, WeightUnit to) {
    // Implement weight conversion logic here
    return 0.0; // Placeholder return value
  }

  double convertTemperature(
      double value, TemperatureUnit from, TemperatureUnit to) {
    // Implement temperature conversion logic here
    return 0.0; // Placeholder return value
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scientific Calculator'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              alignment: Alignment.bottomRight,
              child: Text(
                _display,
                style: const TextStyle(fontSize: 32),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.all(10),
              child: GridView.builder(
                itemCount: _buttonValues.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  String buttonText = _buttonValues[index];
                  return CalculatorButton(
                    text: buttonText,
                    onPressed: () => _onButtonPressed(buttonText),
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                const Text(
                  'History',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _history.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(_history[index]),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CalculatorButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CalculatorButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: const Color.fromARGB(255, 180, 127, 196),
      textColor: Colors.black,
      child: Text(
        text,
        style: const TextStyle(fontSize: 20),
      ),
    );
  }
}
