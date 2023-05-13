import 'dart:math' as math;
import '../../exceptions.dart';
import 'status_codes.dart';

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
part 'value.array.dart';
part 'value.target.dart';
part 'value.type.dart';

class Value extends StatusCode {
  const Value._() : super();

  static const $void = Value._();

  @override
  String toString() => (this == $void) ? '(void)' : '$runtimeType($value)';

  dynamic get value => null;

  ComplexValue toComplex() => _notSupported(runtimeType);
  FloatValue toFloat() => _notSupported(runtimeType);
  IntValue toInt() => _notSupported(runtimeType);
  BitValue toBit() => _notSupported(runtimeType);
  BoolValue toBool() => _notSupported(runtimeType);
  AngleValue toAngle() => _notSupported(runtimeType);

  Value? promoteFor(Value a) => _notSupported(runtimeType);
  Value promote(Value a) => _notSupported(runtimeType);

  Value add(Value a) => _notSupported(runtimeType);
  Value sub(Value a) => _notSupported(runtimeType);
  Value mul(Value a) => _notSupported(runtimeType);
  Value div(Value a) => _notSupported(runtimeType);
  Value mod(Value a) => _notSupported(runtimeType);

  BoolValue and(Value a) => toBool().and(a);
  BoolValue or(Value a) => toBool().or(a);
  BoolValue xor(Value a) => toBool().xor(a);

  Value bitAnd(Value a) => _notSupported(runtimeType);
  Value bitOr(Value a) => _notSupported(runtimeType);
  Value bitXor(Value a) => _notSupported(runtimeType);
  Value shiftr(Value a) => _notSupported(runtimeType);
  Value shiftl(Value a) => _notSupported(runtimeType);
  Value rotl(Value a) => _notSupported(runtimeType);
  Value rotr(Value a) => _notSupported(runtimeType);

  BoolValue eq(Value a) => _notSupported(runtimeType);
  BoolValue neq(Value a) => eq(a).not();
  BoolValue lt(Value a) => _notSupported(runtimeType);
  BoolValue lte(Value a) => _notSupported(runtimeType);
  BoolValue gt(Value a) => lte(a).not();
  BoolValue gte(Value a) => gte(a).not();

  Value neg() => _notSupported(runtimeType);
  BoolValue not() => toBool().not();
  Value twoCompl() => _notSupported(runtimeType);

  Value cast(BaseType type) {
    if (type is ComplexType) {
      return toComplex();
    } else if (type is FloatType) {
      return toFloat();
    } else if (type is IntType) {
      return toInt();
    } else if (type is BitType) {
      return toBit();
    } else if (type is BoolType) {
      return toBool();
    } else if (type is AngleType) {
      return toAngle();
    } else {
      throw Exception('Unsupported conversion');
    }
  }

  Value pow(Value a) => _notSupported(runtimeType);
  Value sqrt() => _notSupported(runtimeType);
  Value exp() => _notSupported(runtimeType);
  Value log() => _notSupported(runtimeType);
}

dynamic _notSupported(Type type) => throw Exception('Not supported in $type');

double _clamp(double x, {double precision = 1e-14}) {
  if ((x - x.ceilToDouble()).abs() < precision) {
    return x.ceilToDouble();
  } else if ((x - x.floorToDouble()).abs() < precision) {
    return x.floorToDouble();
  } else {
    return x;
  }
}
