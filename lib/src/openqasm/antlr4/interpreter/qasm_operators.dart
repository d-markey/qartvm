import 'dart:math' as math;

import '../../interpreter/value.dart';
import 'qasm_context.dart';

class ValueOperations {
  static final _unaryOps = <String, Value Function(Value)>{
    '!': (val) => val.not(),
    '-': (val) => val.neg(),
  };

  static Value Function(Value)? getUnary(String op) => _unaryOps[op];

  static Value computeUnary(String op, Value value) {
    final operation = getUnary(op);
    if (operation == null) {
      throw UnsupportedError('Unsupported unary operator $op');
    }
    return operation(value);
  }

  static final _binaryOps = <String, Value Function(Value, Value)>{
    // comparisons
    '==': (left, right) => left.eq(right),
    '!=': (left, right) => left.neq(right),
    '<': (left, right) => left.lt(right),
    '<=': (left, right) => left.lte(right),
    '>': (left, right) => left.gt(right),
    '>=': (left, right) => left.gte(right),
    // operations
    '+': (left, right) => left.add(right),
    '-': (left, right) => left.sub(right),
    '*': (left, right) => left.mul(right),
    '/': (left, right) => left.div(right),
    '%': (left, right) => left.mod(right),
    '**': (left, right) => left.pow(right),
  };

  static Value Function(Value, Value)? getBinary(String op) => _binaryOps[op];

  static Value computeBinary(Value left, String op, Value right) {
    final operation = getBinary(op);
    if (operation == null) {
      throw UnsupportedError('Unsupported binary operator $op');
    }
    return operation(left, right);
  }

  static final _assignmentOps = <String, void Function(Variable, Value)>{
    '=': (variable, val) => variable.set(val),
    '+=': (variable, val) => variable.set(variable.value!.add(val)),
    '-=': (variable, val) => variable.set(variable.value!.sub(val)),
    '*=': (variable, val) => variable.set(variable.value!.mul(val)),
    '/=': (variable, val) => variable.set(variable.value!.div(val)),
    '%=': (variable, val) => variable.set(variable.value!.mod(val)),
    '|=': (variable, val) => variable.set(variable.value!.toBool().or(val)),
    '&=': (variable, val) => variable.set(variable.value!.toBool().and(val)),
  };

  static void Function(Variable, Value)? getAssignmentOp(String op) =>
      _assignmentOps[op];

  static void assign(Variable target, String op, Value operand) {
    final operation = getAssignmentOp(op);
    if (operation == null) {
      throw UnsupportedError('Unsupported assignment operator $op');
    }
    operation(target, operand);
  }

  static final _builtInFunctions = <String, Value Function(Iterable<Value>)>{
    'print': (values) {
      final str = values.map((v) => v is StringValue ? v.value : v.toString());
      print('[${DateTime.now().toIso8601String()}] ${str.join(' ')}');
      return Value.$void;
    },
    'real': (values) => FloatValue(values.single.toComplex().re),
    'imag': (values) => FloatValue(values.single.toComplex().im),
    'abs': (values) => FloatValue(values.single.toFloat().value.abs()),
    'arccos': (values) => FloatValue(math.acos(values.single.toFloat().value)),
    'arcsin': (values) => FloatValue(math.asin(values.single.toFloat().value)),
    'arctan': (values) => FloatValue(math.atan(values.single.toFloat().value)),
    'ceiling': (values) =>
        FloatValue(values.single.toFloat().value.ceilToDouble()),
    'cos': (values) => FloatValue(math.cos(values.single.toFloat().value)),
    'exp': (values) => values.single.exp(),
    'floor': (values) =>
        FloatValue(values.single.toFloat().value.floorToDouble()),
    'log': (values) => values.single.log(),
    'mod': (values) => values.first.mod(values.skip(1).single),
    'popcount': (values) => values.single.toBit().popCount(),
    'pow': (values) => values.first.pow(values.skip(1).single),
    'rotl': (values) => values.first.rotl(values.skip(1).single),
    'rotr': (values) => values.first.rotr(values.skip(1).single),
    'sin': (values) => FloatValue(math.sin(values.single.toFloat().value)),
    'sqrt': (values) => values.single.sqrt(),
    'tan': (values) => FloatValue(math.tan(values.single.toFloat().value)),
  };

  static Value Function(Iterable<Value>)? getBuiltinFunction(String func) =>
      _builtInFunctions[func];
}
