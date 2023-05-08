import 'dart:math' as math;
import '../../exceptions.dart';
import '../_tokenizer.dart';
import '../ast/ast_node.dart';

part 'value.angle.dart';
part 'value.bit.dart';
part 'value.bool.dart';
part 'value.complex.dart';
part 'value.float.dart';
part 'value.int.dart';
part 'value.string.dart';
part 'value.iterable.dart';
part 'value.set.dart';
part 'value.range.dart';

class Value {
  const Value._();

  static const $void = Value._();

  @override
  String toString() => (this == $void) ? '(void)' : '$runtimeType($value)';

  dynamic get value => null;

  ComplexValue toComplex() => _notSupported();
  FloatValue toFloat() => _notSupported();
  IntValue toInt() => _notSupported();
  BitValue toBit() => _notSupported();
  BoolValue toBool() => _notSupported();
  AngleValue toAngle() => _notSupported();

  Value? promoteFor(Value a) => _notSupported();
  Value promote(Value a) => _notSupported();

  Value add(Value a) => _notSupported();
  Value sub(Value a) => _notSupported();
  Value mul(Value a) => _notSupported();
  Value div(Value a) => _notSupported();
  Value mod(Value a) => _notSupported();

  BoolValue and(Value a) => toBool().and(a);
  BoolValue or(Value a) => toBool().or(a);
  BoolValue xor(Value a) => toBool().xor(a);

  Value bitAnd(Value a) => _notSupported();
  Value bitOr(Value a) => _notSupported();
  Value bitXor(Value a) => _notSupported();
  Value shiftr(Value a) => _notSupported();
  Value shiftl(Value a) => _notSupported();
  Value rotl(Value a) => _notSupported();
  Value rotr(Value a) => _notSupported();

  BoolValue eq(Value a) => _notSupported();
  BoolValue neq(Value a) => eq(a).not();
  BoolValue lt(Value a) => _notSupported();
  BoolValue lte(Value a) => _notSupported();
  BoolValue gt(Value a) => lte(a).not();
  BoolValue gte(Value a) => gte(a).not();

  Value neg() => _notSupported();
  BoolValue not() => toBool().not();
  Value twoCompl() => _notSupported();

  Value cast(AstType type) {
    switch (type.type.text) {
      case Types.$complex:
        return toComplex();
      case Types.$float:
        return toFloat();
      case Types.$int:
        return toInt();
      case Types.$uint:
        throw Exception('Unsupported conversion');
      case Types.$bit:
        return toBit();
      case Types.$bool:
        return toBool();
      case Types.$angle:
        return toAngle();
      default:
        throw Exception('Unsupported conversion');
    }
  }

  Value pow(Value a) => _notSupported();
  Value sqrt() => _notSupported();
  Value exp() => _notSupported();
  Value log() => _notSupported();
}

dynamic _notSupported() => throw Exception('Not supported');

double _clamp(double x, {double precision = 1e-14}) {
  if ((x - x.ceilToDouble()).abs() < precision) {
    return x.ceilToDouble();
  } else if ((x - x.floorToDouble()).abs() < precision) {
    return x.floorToDouble();
  } else {
    return x;
  }
}
