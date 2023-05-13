part of 'value.dart';

class ArrayValue extends IterableValue {
  ArrayValue.from(Iterable<Value> values)
      : _values = values.toList(),
        super._();

  final List<Value> _values;

  @override
  Iterable<Value> get value => _values;

  Value operator [](int index) => _values[index];

  void operator []=(int index, Value value) => _values[index] = value;

  @override
  String toString() => 'Array[${_values.length}]';

  @override
  ComplexValue toComplex() => throw InvalidOperationException('Cannot convert');

  @override
  FloatValue toFloat() => throw InvalidOperationException('Cannot convert');

  @override
  IntValue toInt() => throw InvalidOperationException('Cannot convert');

  @override
  BitValue toBit() => throw InvalidOperationException('Cannot convert');

  @override
  BoolValue toBool() => throw InvalidOperationException('Cannot convert');

  @override
  AngleValue toAngle() => throw InvalidOperationException('Cannot convert');

  @override
  Value? promoteFor(Value a) =>
      throw InvalidOperationException('Cannot convert');

  @override
  FloatValue promote(Value a) =>
      throw InvalidOperationException('Cannot convert');

  @override
  BoolValue eq(Value a) => throw InvalidOperationException('Cannot convert');

  @override
  BoolValue lt(Value a) => throw InvalidOperationException('Cannot convert');

  @override
  BoolValue lte(Value a) => throw InvalidOperationException('Cannot convert');

  @override
  Value add(Value a) => throw InvalidOperationException('Cannot convert');

  @override
  Value sub(Value a) => throw InvalidOperationException('Cannot convert');

  @override
  Value mul(Value a) => throw InvalidOperationException('Cannot convert');

  @override
  Value div(Value a) => throw InvalidOperationException('Cannot convert');

  @override
  Value mod(Value a) => throw InvalidOperationException('Cannot convert');

  @override
  Value pow(Value a) => throw InvalidOperationException('Cannot convert');

  @override
  Value sqrt() => throw InvalidOperationException('Cannot convert');

  @override
  Value exp() => throw InvalidOperationException('Cannot convert');

  @override
  Value log() => throw InvalidOperationException('Cannot convert');
}
