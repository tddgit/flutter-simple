import 'package:flutter_converter/models/enums.dart';
import 'package:flutter/foundation.dart';
import 'dart:math' as math;

enum UNARY_OPERATION {
  product,
  division,
  addition,
  subtraction,
}
enum BINARY_OPERATION {
  squareRoot,
  log10,
  square,
  ln,
  reciprocal,
  factorial,
}

typedef FuncUnaryOperation = double Function(double);

class Calculator with ChangeNotifier {
  final _regExpValidationChar = RegExp(r'^[0-9πe,.+-/=*×÷−]+$');
  final _regExpNumber = RegExp(r'^[0-9πe]+$');

  static const Map<String, UNARY_OPERATION> mapOperation = {
    '*': UNARY_OPERATION.product,
    '/': UNARY_OPERATION.division,
    '+': UNARY_OPERATION.addition,
    '-': UNARY_OPERATION.subtraction,
    '×': UNARY_OPERATION.product,
    '÷': UNARY_OPERATION.division,
    '−': UNARY_OPERATION.subtraction,
  };
  Map<BINARY_OPERATION, FuncUnaryOperation> unaryOperations = {
    BINARY_OPERATION.squareRoot: (math.sqrt),
    BINARY_OPERATION.log10: (double x) => math.log(x) / math.log(10),
    BINARY_OPERATION.square: (double x) => x * x,
    BINARY_OPERATION.ln: math.log,
    BINARY_OPERATION.reciprocal: (double x) => 1 / x,
    BINARY_OPERATION.factorial: (double x) {
      x = x.truncate().toDouble();
      double factorial(double x) {
        return x == 0 ? 1 : x * factorial(x - 1);
      }

      return factorial(x);
    }
  };

  String currentNumber = '';
  double? _firstNumber;
  double? _secondNumber;
  UNARY_OPERATION? selectedOperation;
  bool endNumber = false;
  bool isResult = false;
  String decimalSeparator;

  Calculator({this.decimalSeparator = '.'});

  // Allow to submit any char from -> 0-9, [, . + - * / = backspace canc]
  void _submitChar(String char) {
    // if string is not valid -> return
    if (!(char.length == 1 && _regExpValidationChar.hasMatch(char))) {
      return;
    }

    if (_regExpNumber.hasMatch(char)) {
      if (isResult) {
        isResult = false;
        selectedOperation = _firstNumber = _secondNumber = null;
      }
      if (endNumber) {
        currentNumber = '';
        endNumber = false;
      }

      if (char == 'π') {
        currentNumber = math.pi.toString();
      } else if (char == 'e') {
        currentNumber = math.e.toString();
      } else {
        currentNumber += char;
      }
    } else if (char == '.' || char == ',') {
      if (currentNumber.contains('.') || currentNumber.contains(',')) {
        return;
      }
      currentNumber += '.';
    }
  }

  void _clearAll() {
    currentNumber = '';
    _firstNumber = null;
    _secondNumber = null;
    selectedOperation = null;
    endNumber = false;
    isResult = false;
    notifyListeners();
  }

  void _deleteLastChar() {}

  void _unaryOperation(FuncUnaryOperation operation) {
    if (currentNumber.isNotEmpty) {
      currentNumber = _getStringFromDouble(
          operation(double.parse(currentNumber)), decimalSeparator);
    }
  }

  double _getDoubleFromString(String string) {
    if (string.contains(',')) {
      string = string.replaceAll(RegExp(','), '.');
    }
    return double.parse(string);
  }

  String _getStringFromDouble(double value, [String decimalSeparator = '.']) {
    String stringValue = value.toString();
    if (stringValue.endsWith('.0')) {
      stringValue = stringValue.substring(0, stringValue.length - 2);
    }
    return stringValue;
  }
}
