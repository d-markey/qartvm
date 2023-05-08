part of 'value.dart';

class FloatValue extends Value {
  const FloatValue(this.value) : super._();

  static const $zero = FloatValue(0);
  static const $one = FloatValue(1);
  static const $pi = FloatValue(math.pi);
  static const $tau = FloatValue(2 * math.pi);
  static const $euler = FloatValue(math.e);

  @override
  final double value;

  @override
  String toString() => 'Float(${_clamp(value)})';

  @override
  ComplexValue toComplex() => ComplexValue(value, 0);

  @override
  FloatValue toFloat() => this;

  @override
  IntValue toInt() => IntValue(value.toInt());

  @override
  BitValue toBit() => throw Exception('Unsupported conversion.');

  @override
  BoolValue toBool() => BoolValue(value != 0);

  @override
  AngleValue toAngle() => AngleValue(value);

  @override
  Value? promoteFor(Value a) {
    if (a is ComplexValue) {
      return toComplex();
    } else {
      return null;
    }
  }

  @override
  FloatValue promote(Value a) => a.toFloat();

  @override
  BoolValue eq(Value a) {
    if (a is BoolValue) {
      return toBool().eq(a);
    } else {
      return promoteFor(a)?.eq(a) ?? BoolValue(value == promote(a).value);
    }
  }

  @override
  BoolValue lt(Value a) =>
      promoteFor(a)?.lt(a) ?? BoolValue(value < promote(a).value);

  @override
  BoolValue lte(Value a) =>
      promoteFor(a)?.lte(a) ?? BoolValue(value <= promote(a).value);

  @override
  Value neg() => FloatValue(-value);

  @override
  Value add(Value a) =>
      promoteFor(a)?.add(a) ?? FloatValue(value + promote(a).value);

  @override
  Value sub(Value a) =>
      promoteFor(a)?.sub(a) ?? FloatValue(value - promote(a).value);

  @override
  Value mul(Value a) =>
      promoteFor(a)?.mul(a) ?? FloatValue(value * promote(a).value);

  @override
  Value div(Value a) =>
      promoteFor(a)?.div(a) ?? FloatValue(value / promote(a).value);

  @override
  Value mod(Value a) =>
      promoteFor(a)?.mod(a) ?? FloatValue(value % promote(a).value);

  @override
  Value pow(Value a) =>
      promoteFor(a)?.pow(a) ??
      FloatValue(math.pow(value, promote(a).value).toDouble());

  @override
  Value sqrt() => FloatValue(math.sqrt(value));

  @override
  Value exp() => FloatValue(math.exp(value));

  @override
  Value log() => FloatValue(math.log(value));
}
