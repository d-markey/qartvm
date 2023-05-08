part of 'value.dart';

class AngleValue extends Value {
  AngleValue(double value)
      : angle = (value % FloatValue.$tau.value),
        super._();

  final double angle;

  @override
  dynamic get value => {'rad': angle};

  @override
  String toString() {
    var d = _clamp((128 * angle) / FloatValue.$pi.value) / 128;
    return 'Angle($d pi))';
  }

  @override
  ComplexValue toComplex() => toFloat().toComplex();

  @override
  FloatValue toFloat() => FloatValue(angle);

  @override
  AngleValue toAngle() => this;

  @override
  Value? promoteFor(Value a) => null;

  @override
  AngleValue promote(Value a) => AngleValue(a.toFloat().value);

  @override
  BoolValue eq(Value a) {
    if (a is BoolValue) {
      return toBool().eq(a);
    } else {
      return promoteFor(a)?.eq(a) ?? BoolValue(angle == promote(a).angle);
    }
  }

  @override
  BoolValue lt(Value a) => BoolValue(angle < promote(a).angle);

  @override
  BoolValue lte(Value a) => BoolValue(angle <= promote(a).angle);

  @override
  Value add(Value a) => AngleValue(angle + promote(a).angle);

  @override
  Value sub(Value a) => AngleValue(angle - promote(a).angle);

  @override
  Value mul(Value a) => (a is! AngleValue)
      ? AngleValue(angle * a.toFloat().value)
      : throw Exception('Invalid operation.');

  @override
  Value div(Value a) => (a is! AngleValue)
      ? AngleValue(angle / a.toFloat().value)
      : throw Exception('Invalid operation.');

  @override
  Value neg() => AngleValue(-angle);

  @override
  Value pow(Value a) => (a is! AngleValue)
      ? toFloat().pow(a).toAngle()
      : throw Exception('Invalid operation.');
}
