part of 'value.dart';

class RangeValue extends IterableValue {
  const RangeValue(this.start, this.end, this.incr) : super._();

  final Value start;
  final Value end;
  final Value incr;

  @override
  Iterable<Value> get value sync* {
    var v = start;
    yield v;
    while (true) {
      if (v.gt(end).value) {
        break;
      }
      yield v;
      v = v.add(incr);
    }
  }

  @override
  String toString() => 'Range()';

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
