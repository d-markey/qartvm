part of 'value.dart';

class BitValue extends Value {
  BitValue(this.value) : super._();

  @override
  final int value;

  @override
  String toString() => 'Bit($value)';

  @override
  ComplexValue toComplex() => toInt().toComplex();

  @override
  FloatValue toFloat() => toInt().toFloat();

  @override
  IntValue toInt() => IntValue(value);

  @override
  BitValue toBit() => this;

  @override
  BoolValue toBool() => toInt().toBool();

  @override
  Value? promoteFor(Value a) => toInt();

  @override
  BitValue promote(Value a) => a.toBit();

  @override
  BoolValue eq(Value a) => toInt().eq(a);

  @override
  BoolValue lt(Value a) => toInt().lt(a);

  @override
  BoolValue lte(Value a) => toInt().lte(a);

  @override
  Value add(Value a) => toInt().add(a);

  @override
  Value sub(Value a) => toInt().sub(a);

  @override
  Value mul(Value a) => toInt().mul(a);

  @override
  Value div(Value a) => toInt().div(a);

  @override
  Value mod(Value a) => toInt().mod(a);

  @override
  Value bitAnd(Value a) => toInt().bitAnd(a);

  @override
  Value bitOr(Value a) => toInt().bitOr(a);

  @override
  Value bitXor(Value a) => toInt().bitXor(a);

  @override
  Value neg() => toInt().neg();

  @override
  Value twoCompl() => toInt().twoCompl();

  @override
  Value pow(Value a) => toInt().pow(a);

  @override
  Value sqrt() => toInt().sqrt();

  @override
  Value exp() => toInt().exp();

  @override
  Value log() => toInt().log();

  IntValue popCount() {
    var count = 0;
    var v = value;
    while (v != 0) {
      if ((v & 0x01) != 0) {
        count += 1;
      }
      v >>= 1;
    }
    return IntValue(count);
  }
}
