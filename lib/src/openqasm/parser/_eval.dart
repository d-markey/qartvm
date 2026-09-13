import 'dart:math' as math;

import '../../math/complex.dart';
import 'ast_nodes.dart';

bool toBool(dynamic value) => applyCast(value, .bool);

int toInt(dynamic value) => applyCast(value, .int);

double toFloat(dynamic value) => applyCast(value, .float);

Complex toComplex(dynamic value) => applyCast(value, .complex);

dynamic applyCast(dynamic value, LiteralType type) {
  switch (type) {
    case .any:
      return value;
    case .bool:
      if (value is num) return (value != 0);
      if (value is Complex) return value.isNonZero;
      if (value is String) return value.isNotEmpty;
      return (value as bool);
    case .uint:
    case .int:
      if (value is String) return double.tryParse(value);
      if (value is Complex && value.im == 0) return value.re;
      return (value as num).toInt();
    case .float:
      if (value is String) return double.tryParse(value);
      if (value is Complex && value.im == 0) return value.re;
      return (value as num).toDouble();
    case .complex:
      if (value is num) return Complex(re: value.toDouble());
      return value as Complex;
    case .string:
      return value.toString();
    case .bitstring:
      if (value is int) return value;
      if (value is String) {
        return int.parse(value.trim().replaceAll('_', ''), radix: 2);
      }
    case .timing:
    // unsupported
  }
  throw Exception('Cannot cast ${value.runtimeType} to $type');
}

dynamic applyBinaryOp(dynamic left, String operator, dynamic right) =>
    switch (operator) {
      // Arithmetic
      '+' => left + right,
      '-' => left - right,
      '*' => left * right,
      '/' => left / right,
      '%' => toFloat(left) % toFloat(right),
      '**' => math.pow(toFloat(left), toFloat(right)),

      // Bitwise
      '&' => toInt(left) & toInt(right),
      '|' => toInt(left) | toInt(right),
      '^' => toInt(left) ^ toInt(right),
      '<<' => toInt(left) << toInt(right),
      '>>' => toInt(left) >> toInt(right),

      // Logical
      '&&' => toBool(left) && toBool(right),
      '||' => toBool(left) || toBool(right),

      // Comparison
      '==' => left == right,
      '!=' => left != right,
      '<' => toFloat(left) < toFloat(right),
      '>' => toFloat(left) > toFloat(right),
      '<=' => toFloat(left) <= toFloat(right),
      '>=' => toFloat(left) >= toFloat(right),

      // Unsupported
      _ => null,
    };

dynamic applyUnaryOp(String operator, dynamic value) => switch (operator) {
  '-' => -value,
  '!' => !toBool(value),
  '~' => ~toInt(value),
  _ => null,
};

dynamic applyAssignmentOp(dynamic left, String operator, dynamic right) =>
    switch (operator) {
      '+=' => left + right,
      '-=' => left - right,
      '*=' => left * right,
      '/=' => left / right,
      '%=' => toFloat(left) % toFloat(right),
      '<<=' => toInt(left) << toInt(right),
      '>>=' => toInt(left) >> toInt(right),
      '&=' => toInt(left) & toInt(right),
      '|=' => toInt(left) | toInt(right),
      '^=' => toInt(left) ^ toInt(right),
      _ => null,
    };
