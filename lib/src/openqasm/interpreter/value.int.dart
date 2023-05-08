part of 'value.dart';

class IntValue extends Value {
  const IntValue(this.value) : super._();

  static const $zero = IntValue(0);
  static const $one = IntValue(1);

  @override
  final int value;

  @override
  String toString() => 'Int($value)';

  @override
  ComplexValue toComplex() => ComplexValue(value.toDouble(), 0);

  @override
  FloatValue toFloat() => FloatValue(value.toDouble());

  @override
  IntValue toInt() => this;

  @override
  BitValue toBit() => BitValue(value);

  @override
  BoolValue toBool() => BoolValue(value != 0);

  @override
  Value? promoteFor(Value a) {
    if (a is ComplexValue) {
      return toComplex();
    } else if (a is FloatValue || a is AngleValue) {
      return toFloat();
    } else {
      return null;
    }
  }

  @override
  IntValue promote(Value a) => a.toInt();

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
  Value add(Value a) =>
      promoteFor(a)?.add(a) ?? IntValue(value + promote(a).value);

  @override
  Value sub(Value a) =>
      promoteFor(a)?.sub(a) ?? IntValue(value - promote(a).value);

  @override
  Value mul(Value a) =>
      promoteFor(a)?.mul(a) ?? IntValue(value * promote(a).value);

  @override
  Value div(Value a) =>
      promoteFor(a)?.div(a) ?? IntValue(value ~/ promote(a).value);

  @override
  Value mod(Value a) =>
      promoteFor(a)?.mod(a) ?? IntValue(value % promote(a).value);

  @override
  Value pow(Value a) =>
      promoteFor(a)?.pow(a) ??
      IntValue(math.pow(value, promote(a).value).toInt());

  @override
  Value sqrt() => FloatValue(math.sqrt(value));

  @override
  Value exp() => FloatValue(math.exp(value));

  @override
  Value log() => FloatValue(math.log(value));
}
