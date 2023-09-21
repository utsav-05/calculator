import 'package:flutter/material.dart';

void main() => runApp(CalculatorApp());

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _output = '0';
  String _input = '';
  double _result = 0.0;

  void _buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        _input = '';
        _output = '0';
        _result = 0.0;
      } else if (buttonText == '=') {
        try {
          _result = eval(_input);
          _output = _result.toString();
        } catch (e) {
          _output = 'Error';
        }
      } else {
        _input += buttonText;
        _output = _input;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16.0),
              alignment: Alignment.bottomRight,
              child: Text(
                _output,
                style: TextStyle(
                  fontSize: 48.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Divider(),
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  _buildButton('7'),
                  _buildButton('8'),
                  _buildButton('9'),
                  _buildButton('/'),
                ],
              ),
              Row(
                children: <Widget>[
                  _buildButton('4'),
                  _buildButton('5'),
                  _buildButton('6'),
                  _buildButton('*'),
                ],
              ),
              Row(
                children: <Widget>[
                  _buildButton('1'),
                  _buildButton('2'),
                  _buildButton('3'),
                  _buildButton('-'),
                ],
              ),
              Row(
                children: <Widget>[
                  _buildButton('C'),
                  _buildButton('0'),
                  _buildButton('='),
                  _buildButton('+'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String buttonText) {
    return Expanded(
      child: FlatButton(
        padding: EdgeInsets.all(24.0),
        onPressed: () => _buttonPressed(buttonText),
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 24.0,
          ),
        ),
      ),
    );
  }

  double eval(String expression) {
    Parser p = Parser();
    ContextModel cm = ContextModel();
    Expression exp = p.parse(expression);
    var EvaluationType;
    return exp.evaluate(EvaluationType.REAL, cm);
  }

  FlatButton({required EdgeInsets padding, required void Function() onPressed, required Text child}) {}
}

class Expression {
  double evaluate(real, ContextModel cm) {}
}

class ContextModel {
}

class Parser {
  Expression parse(String expression) {}
}
