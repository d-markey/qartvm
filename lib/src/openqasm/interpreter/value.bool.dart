part of 'value.dart';

class BoolValue extends Value {
  const BoolValue._(this.value) : super._();

  factory BoolValue(bool value) => value ? $true : $false;

  static const $true = BoolValue._(true);
  static const $false = BoolValue._(false);

  @override
  final bool value;

  @override
  String toString() => 'Bool($value)';

  @override
  ComplexValue toComplex() => value ? ComplexValue.$one : ComplexValue.$zero;

  @override
  FloatValue toFloat() => value ? FloatValue.$one : FloatValue.$zero;

  @override
  IntValue toInt() => value ? IntValue.$one : IntValue.$zero;

  @override
  BoolValue toBool() => this;

  @override
  Value? promoteFor(Value a) {
    if (a is ComplexValue) {
      return toComplex();
    } else if (a is FloatValue) {
      return toFloat();
    } else if (a is IntValue) {
      return toInt();
    } else if (a is BitValue) {
      return toBit();
    } else {
      return null;
    }
  }

  @override
  BoolValue promote(Value a) => a.toBool();

  @override
  BoolValue eq(Value a) => BoolValue(value == promote(a).value);

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
  BoolValue and(Value a) => BoolValue(value && promote(a).value);

  @override
  BoolValue or(Value a) => BoolValue(value || promote(a).value);

  @override
  BoolValue xor(Value a) => BoolValue(value ^ promote(a).value);

  @override
  Value bitAnd(Value a) => toInt().bitAnd(a);

  @override
  Value bitOr(Value a) => toInt().bitOr(a);

  @override
  Value bitXor(Value a) => toInt().bitXor(a);

  @override
  Value neg() => toInt().neg();

  @override
  BoolValue not() => BoolValue(!value);

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
}
