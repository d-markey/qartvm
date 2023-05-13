part of 'value.dart';

abstract class BaseType extends Value {
  const BaseType._() : super._();
}

abstract class ScalarType extends BaseType {
  const ScalarType._() : super._();
}

class ArrayType extends BaseType {
  const ArrayType(this.type, this.dimensions) : super._();

  final BaseType type;
  final dynamic dimensions;
}

class BitType extends ScalarType {
  const BitType([this.designator]) : super._();

  final Value? designator;

  @override
  String toString() =>
      (designator == null) ? 'Bit' : 'Bit[${designator!.value}]';
}

class IntType extends ScalarType {
  const IntType([this.designator]) : super._();

  final Value? designator;

  @override
  String toString() =>
      (designator == null) ? 'Int' : 'Int[${designator!.value}]';
}

class UintType extends ScalarType {
  const UintType([this.designator]) : super._();

  final Value? designator;

  @override
  String toString() =>
      (designator == null) ? 'Uint' : 'Uint[${designator!.value}]';
}

class FloatType extends ScalarType {
  const FloatType([this.designator]) : super._();

  final Value? designator;

  @override
  String toString() =>
      (designator == null) ? 'Float' : 'Float[${designator!.value}]';
}

class AngleType extends ScalarType {
  const AngleType([this.designator]) : super._();

  final Value? designator;

  @override
  String toString() =>
      (designator == null) ? 'Angle' : 'Angle[${designator!.value}]';
}

class BoolType extends ScalarType {
  const BoolType._() : super._();

  static const _instance = BoolType._();

  factory BoolType() => _instance;

  @override
  String toString() => 'Bool';
}

class DurationType extends ScalarType {
  const DurationType._() : super._();

  static const _instance = DurationType._();

  factory DurationType() => _instance;

  @override
  String toString() => 'Duration';
}

class StretchType extends ScalarType {
  const StretchType._() : super._();

  static const _instance = StretchType._();

  factory StretchType() => _instance;

  @override
  String toString() => 'Stretch';
}

class ComplexType extends ScalarType {
  const ComplexType([this.type]) : super._();

  final BaseType? type;

  @override
  String toString() => (type == null) ? 'Complex' : 'Complex[$type]';
}

class StringType extends BaseType {
  const StringType() : super._();

  @override
  String toString() => 'String';
}
