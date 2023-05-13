part of 'value.dart';

class StringValue extends Value {
  StringValue(this._value) : super._();

  final String _value;

  @override
  String get value => _value.substring(1, _value.length - 1);

  @override
  String toString() => 'String($value)';

  @override
  ComplexValue toComplex() => toBit().toComplex();

  @override
  FloatValue toFloat() => toBit().toFloat();

  @override
  IntValue toInt() => toBit().toInt();

  @override
  BitValue toBit() => BitValue(int.parse(value, radix: 2));

  @override
  BoolValue toBool() => toBit().toBool();

  @override
  Value? promoteFor(Value a) => (a is StringValue) ? null : toBit();

  @override
  BoolValue eq(Value a) {
    if (a is StringValue) {
      return BoolValue(value == a.value);
    } else {
      return toBit().eq(a);
    }
  }

  @override
  BoolValue lt(Value a) => toBit().lt(a);

  @override
  BoolValue lte(Value a) => toBit().lte(a);

  @override
  Value add(Value a) => toBit().add(a);

  @override
  Value sub(Value a) => toBit().sub(a);

  @override
  Value mul(Value a) => toBit().mul(a);

  @override
  Value div(Value a) => toBit().div(a);

  @override
  Value mod(Value a) => toBit().mod(a);

  @override
  Value bitAnd(Value a) => toBit().bitAnd(a);

  @override
  Value bitOr(Value a) => toBit().bitOr(a);

  @override
  Value bitXor(Value a) => toBit().bitXor(a);

  @override
  Value neg() => toBit().neg();

  @override
  Value twoCompl() => toBit().twoCompl();

  @override
  Value pow(Value a) => toBit().pow(a);

  @override
  Value sqrt() => toBit().sqrt();

  @override
  Value exp() => toBit().exp();

  @override
  Value log() => toBit().log();
}
