import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _output = "0";
  String _currentInput = "";
  String _operator = "";
  double _firstNumber = 0.0;
  double _secondNumber = 0.0;
  String _history = "";

  void _buttonPressed(String value) {
    setState(() {
      if (value == "C") {
        _clearAll();
      } else if (value == "+" || value == "-" || value == "x" || value == "÷") {
        _setOperator(value);
      } else if (value == "=") {
        _calculateResult();
      } else {
        _appendInput(value);
      }
    });
  }

  void _clearAll() {
    _output = "0";
    _currentInput = "";
    _operator = "";
    _firstNumber = 0.0;
    _secondNumber = 0.0;
    _history = "";
  }

  void _setOperator(String operator) {
    if (_currentInput.isNotEmpty) {
      _operator = operator;
      _firstNumber = double.tryParse(_currentInput) ?? 0.0;
      _history += "$_currentInput $operator ";
      _currentInput = "";
    }
  }

  void _calculateResult() {
    if (_currentInput.isNotEmpty && _operator.isNotEmpty) {
      _secondNumber = double.tryParse(_currentInput) ?? 0.0;

      switch (_operator) {
        case "+":
          _output = (_firstNumber + _secondNumber).toString();
          break;
        case "-":
          _output = (_firstNumber - _secondNumber).toString();
          break;
        case "x":
          _output = (_firstNumber * _secondNumber).toString();
          break;
        case "÷":
          _output = _secondNumber != 0
              ? (_firstNumber / _secondNumber).toString()
              : "Error";
          break;
        default:
          _output = "Error";
          break;
      }

      _history += "$_currentInput = ";
      _currentInput = _output;
      _operator = "";
    }
  }

  void _appendInput(String value) {
    if (value == "." && _currentInput.contains(".")) return;
    _currentInput += value;
    _output = _currentInput;
  }

  Widget _buildButton(String value, {Color? color}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 9),
            backgroundColor: color ?? Colors.grey[800],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () => _buttonPressed(value),
          child: Text(
            value,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Calculadora',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(10.0),
              child: Text(
                _history,
                style: const TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(20.0),
              child: Text(
                _output,
                style: const TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Column(
              children: [
                Row(
                  children: [
                    _buildButton("C", color: Colors.red),
                    _buildButton("÷", color: Colors.orange),
                    _buildButton("x", color: Colors.orange),
                    _buildButton("-", color: Colors.orange),
                  ],
                ),
                Row(
                  children: [
                    _buildButton("7"),
                    _buildButton("8"),
                    _buildButton("9"),
                    _buildButton("+", color: Colors.orange),
                  ],
                ),
                Row(
                  children: [
                    _buildButton("4"),
                    _buildButton("5"),
                    _buildButton("6"),
                    _buildButton("=", color: Colors.green),
                  ],
                ),
                Row(
                  children: [
                    _buildButton("1"),
                    _buildButton("2"),
                    _buildButton("3"),
                    _buildButton("0"),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}