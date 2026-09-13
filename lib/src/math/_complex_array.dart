import 'dart:math';
import 'dart:typed_data';

import '../utils/exceptions.dart';
import '../utils/extensions.dart';
import 'complex.dart';

/// Class holding a list of [Complex] values
extension type ComplexArray._(Float64List _values) {
  /// Builds a list from [values]
  factory ComplexArray._clone(Iterable<double> values) {
    final copy = Float64List(values.length);
    copy.setRange(0, copy.length, values);
    return ComplexArray._(copy);
  }

  /// Builds a list of [length] elements initialized to [Complex.zero]
  factory ComplexArray.zero(int length) =>
      ComplexArray._(Float64List(length * 2));

  /// Returns the underlying values
  Float64List get values => _values;

  int get memoryFootprint => _values.lengthInBytes;

  /// Number of elements in the list
  int get length => _values.length ~/ 2;

  /// Obtains the value stored at index [idx]
  Complex operator [](int idx) {
    final n = idx * 2;
    return Complex(re: _values[n], im: _values[n + 1]);
  }

  /// Obtains the real part of the value stored at index [idx]
  double re(int idx) => _values[idx * 2];

  /// Obtains the imaginary part of the value stored at index [idx]
  double im(int idx) => _values[idx * 2 + 1];

  /// Obtains the squared modulus of the value at index [idx]
  /// this is equal to [re]([idx]) * [re]([idx]) + [im]([idx]) * [im]([idx])
  double modulus2(int idx) {
    final n = idx * 2;
    final re = _values[n], im = _values[n + 1];
    return re * re + im * im;
  }

  /// Obtains the modulus of the value at index [idx]
  /// this is equal to sqrt([modulus2]))
  double modulus(int idx) => sqrt(modulus2(idx));

  /// Copies values from [other] into this instance
  /// [other].[length] must match the [length] of this instance
  ComplexArray copy(ComplexArray other) {
    if (length != other.length) {
      throw InvalidOperationException();
    }
    _values.setRange(0, _values.length, other._values);
    return this;
  }

  /// Creates a clone of this instance
  ComplexArray clone() => ComplexArray._clone(_values);

  /// Resets all values to [Complex.zero]
  void reset() => _values.fillRange(0, _values.length, 0);

  /// Exchanges values stored at indices [idx1] and [idx2]
  void swap(int idx1, int idx2) {
    if (idx1 == idx2) return;
    final n1 = idx1 * 2, n2 = idx2 * 2;
    final re1 = _values[n1], im1 = _values[n1 + 1];
    _values[n1] = _values[n2];
    _values[n1 + 1] = _values[n2 + 1];
    _values[n2] = re1;
    _values[n2 + 1] = im1;
  }

  /// Negates the value stored at index [idx]
  void neg(int idx) {
    final n = idx * 2;
    _values[n] = -_values[n];
    _values[n + 1] = -_values[n + 1];
  }

  /// Conjugates the value stored at index [idx]
  void conj(int idx) {
    final n = idx * 2;
    _values[n + 1] = -_values[n + 1];
  }

  /// Inverts the value stored at index [idx]
  void inv(int idx) {
    final n = idx * 2;
    final re = _values[n], im = _values[n + 1], m2 = re * re + im * im;
    _values[n] = re / m2;
    _values[n + 1] = -im / m2;
  }

  /// Adds values from [a] at index [ai] and [b] at index [bi] and stores the result in this instance at index [idx]
  void add(int idx, ComplexArray a, int ai, ComplexArray b, int bi) {
    final n = idx * 2, an = ai * 2, bn = bi * 2;
    _values[n] = a._values[an] + b._values[bn];
    _values[n + 1] = a._values[an + 1] + b._values[bn + 1];
  }

  /// Subtracts value in [b] at index [bi] from [a] at index [ai] and and stores the result in this instance at index [idx]
  void sub(int idx, ComplexArray a, int ai, ComplexArray b, int bi) {
    final n = idx * 2, an = ai * 2, bn = bi * 2;
    _values[n] = a._values[an] - b._values[bn];
    _values[n + 1] = a._values[an + 1] - b._values[bn + 1];
  }

  /// Multiplies values from [a] at index [ai] and [b] at index [bi] and stores the result in this instance at index [idx]
  void mul(int idx, ComplexArray a, int ai, ComplexArray b, int bi) {
    final n = idx * 2, an = ai * 2, bn = bi * 2;
    final are = a._values[an], aim = a._values[an + 1];
    final bre = b._values[bn], bim = b._values[bn + 1];
    _values[n] = are * bre - aim * bim;
    _values[n + 1] = are * bim + aim * bre;
  }

  /// Divides values in [a] at index [ai] by [b] at index [bi] and stores the result in this instance at index [idx]
  void div(int idx, ComplexArray a, int ai, ComplexArray b, int bi) {
    final n = idx * 2, an = ai * 2, bn = bi * 2;
    final are = a._values[an], aim = a._values[an + 1];
    final bre = b._values[bn], bim = b._values[bn + 1];
    final bm2 = bre * bre + bim * bim;
    _values[n] = (are * bre + aim * bim) / bm2;
    _values[n + 1] = (aim * bre - are * bim) / bm2;
  }

  /// Multiplies values from [a] at index [ai] and [b] at index [bi] and adds the result to the value at index [idx] in this instance
  void addmul(int idx, ComplexArray a, int ai, ComplexArray b, int bi) {
    final n = idx * 2, an = ai * 2, bn = bi * 2;
    final are = a._values[an], aim = a._values[an + 1];
    final bre = b._values[bn], bim = b._values[bn + 1];
    _values[n] += are * bre - aim * bim;
    _values[n + 1] += are * bim + aim * bre;
  }

  /// Returns `true` if the value at index [idx] is [Complex.zero]
  bool isZero(int idx) {
    final n = idx * 2;
    final re = _values[n], im = _values[n + 1];
    return re == 0 && im == 0;
  }

  /// Returns `true` if the value at index [idx] is [Complex.one]
  bool isOne(int idx) {
    final n = idx * 2;
    final re = _values[n], im = _values[n + 1];
    return re == 1 && im == 0;
  }

  /// Sets value at index [idx] with [value]
  void set(int idx, Complex value) {
    final n = idx * 2;
    _values[n] = value.re;
    _values[n + 1] = value.im;
  }

  /// Sets value at index [idx] with the value from [a] at index [ai]
  void assign(int idx, ComplexArray a, int ai) {
    final n = idx * 2, an = ai * 2;
    _values[n] = a._values[an];
    _values[n + 1] = a._values[an + 1];
  }

  /// Multiplies all values in this instance by [factor] ([num] or [Complex] value)
  void scale(Object factor) {
    switch (factor) {
      case num f:
        if (f == 0) reset();
        if (f == 0 || f == 1) return;
        final len = _values.length, df = f.toDouble();
        for (var i = 0; i < len; i++) {
          _values[i] *= df;
        }

      case Complex f:
        final fre = f.re, fim = f.im;
        final len = _values.length;
        if (fim == 0) {
          // Purely real factor: scale re and im by fre directly
          if (fre == 0) reset();
          if (fre == 0 || fre == 1) return;
          for (var i = 0; i < len; i++) {
            _values[i] *= fre;
          }
        } else if (fre == 0) {
          // Purely imaginary factor: (re + i*im) * (i*fim) = -im*fim + i*(re*fim)
          for (var n = 0; n < len; n += 2) {
            final re = _values[n], im = _values[n + 1];
            _values[n] = -im * fim;
            _values[n + 1] = re * fim;
          }
        } else {
          // Full complex multiplication
          for (var n = 0; n < len; n += 2) {
            final re = _values[n], im = _values[n + 1];
            _values[n] = re * fre - im * fim;
            _values[n + 1] = re * fim + im * fre;
          }
        }

      default:
        throw InvalidOperationException();
    }
  }

  /// Divides all values in this instance by [factor] ([num] or [Complex] value)
  void unscale(Object factor) {
    switch (factor) {
      case num f:
        if (f == 1) return;

        final len = _values.length, df = 1 / f;
        for (var i = 0; i < len; i++) {
          _values[i] *= df;
        }

      case final Complex f:
        if (f.isOne) return;

        final len = _values.length;
        var fre = f.re, fim = f.im;

        if (fim == 0) {
          // Pure real divisor: scale everything by 1/fre
          fre = 1 / fre;
          for (var i = 0; i < len; i++) {
            _values[i] *= fre;
          }
        } else if (fre == 0) {
          // Pure imaginary divisor: (re + i*im) / (i*fim) = (im/fim) - i*(re/fim)
          fim = 1 / fim;
          for (var n = 0; n < len; n += 2) {
            final re = _values[n], im = _values[n + 1];
            _values[n] = im * fim;
            _values[n + 1] = -re * fim;
          }
        } else {
          // General complex divisor: precompute inverse magnitude factors
          final fm2 = fre * fre + fim * fim;
          fre /= fm2;
          fim /= fm2;

          for (var n = 0; n < len; n += 2) {
            final re = _values[n], im = _values[n + 1];
            _values[n] = re * fre + im * fim;
            _values[n + 1] = im * fre - re * fim;
          }
        }

      default:
        throw InvalidOperationException();
    }
  }

  /// Returns true if [other] is a [ComplexArray] of same [length] with same values
  /// down to a precision of [precision]
  bool equals(ComplexArray other, {double precision = 0}) {
    final len = _values.length;
    if (len != other._values.length) {
      throw Exception('Array length mismatch');
    }
    final p2 = precision * precision;
    for (var i = 0; i < len; i += 2) {
      final dre = _values[i] - other._values[i];
      final dim = _values[i + 1] - other._values[i + 1];
      if (dre * dre + dim * dim > p2) return false;
    }
    return true;
  }

  String toDisplayString() =>
      r'[' +
      Iterable.generate(
        length ~/ 2,
        (i) =>
            '${_values[2 * i].normalize()} + ${_values[2 * i + 1].normalize()} i',
      ).join(', ') +
      r']';

  List serialize() => _values;

  static ComplexArray deserialize(List json) =>
      ComplexArray._clone(json.map((n) => n.toDouble()));
}
