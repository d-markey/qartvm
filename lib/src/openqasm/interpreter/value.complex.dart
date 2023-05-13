part of 'value.dart';

class ComplexValue extends Value {
  const ComplexValue._(this.re, this.im) : super._();

  factory ComplexValue(double re, double im) {
    if (re == 0 && im == 0) {
      return $zero;
    } else if (re == 1 && im == 0) {
      return $one;
    } else if (re == 0 && im == 1) {
      return $i;
    } else {
      return ComplexValue._(re, im);
    }
  }

  static const $zero = ComplexValue._(0, 0);
  static const $one = ComplexValue._(1, 0);
  static const $i = ComplexValue._(0, 1);

  final double re;
  final double im;

  @override
  dynamic get value => {'re': re, 'im': im};

  @override
  String toString() => (_clamp(im) == 0)
      ? 'Complex(${_clamp(re)})'
      : (_clamp(re) == 0)
          ? 'Complex(${_clamp(im)} i)'
          : 'Complex(${_clamp(re)} ${im >= 0 ? '+' : '-'} ${_clamp(re).abs()} i)';

  @override
  ComplexValue toComplex() => this;

  @override
  FloatValue toFloat() => (im == 0)
      ? FloatValue(re.toDouble())
      : throw Exception('Unsupported conversion.');

  @override
  IntValue toInt() => toFloat().toInt();

  @override
  BitValue toBit() => toFloat().toBit();

  @override
  BoolValue toBool() => BoolValue(re != 0 || im != 0);

  @override
  AngleValue toAngle() => toFloat().toAngle();

  @override
  Value? promoteFor(Value a) => null;

  @override
  ComplexValue promote(Value a) => a.toComplex();

  bool _equals(ComplexValue a) => (re == a.re) && (im == a.im);

  @override
  BoolValue eq(Value a) {
    if (a is BoolValue) {
      return toBool().eq(a);
    } else {
      return BoolValue(_equals(promote(a)));
    }
  }

  @override
  Value neg() => ComplexValue(-re, -im);

  @override
  Value add(Value a) {
    final c = a.toComplex();
    return ComplexValue(re + c.re, im + c.im);
  }

  @override
  Value sub(Value a) {
    final c = a.toComplex();
    return ComplexValue(re - c.re, im - c.im);
  }

  @override
  Value mul(Value a) {
    final c = a.toComplex();
    return ComplexValue(re * c.re - im * c.im, im * c.re + re * c.im);
  }

  @override
  Value div(Value a) {
    final c = a.toComplex();
    final n = c.re * c.re + c.im * c.im;
    return ComplexValue(
        (re * c.re + im * c.im) / n, (im * c.re - re * c.im) / n);
  }

  @override
  Value pow(Value a) {
    final c = a.toComplex();
    return c.mul(log()).exp();
  }

  @override
  Value sqrt() {
    final r = math.sqrt(re * re + im * im);
    final sign = (im > 0) ? 1 : -1;
    return ComplexValue(
        math.sqrt((r + re) / 2), sign * math.sqrt((r - re) / 2));
  }

  @override
  Value exp() {
    final exp = math.exp(re);
    return ComplexValue(exp * math.cos(im), exp * math.sin(im));
  }

  @override
  Value log() {
    return ComplexValue(
        math.log(math.sqrt(re * re + im * im)), math.atan2(im, re));
  }
}
