import 'dart:typed_data';

import '../exceptions.dart';
import '../extensions.dart';
import 'complex.dart';

class ComplexArray {
  ComplexArray(List<Complex> values)
      : _re = Float64List.fromList(values.map((c) => c.re.toDouble()).toList()),
        _im = Float64List.fromList(values.map((c) => c.im.toDouble()).toList());

  ComplexArray.zero(int length)
      : _re = Float64List(length),
        _im = Float64List(length);

  ComplexArray.clone(ComplexArray other)
      : _re = Float64List.fromList(other._re),
        _im = Float64List.fromList(other._im);

  int get length => _re.length;

  final Float64List _re;
  final Float64List _im;

  ComplexArray copy(ComplexArray other) {
    if (length != other.length) {
      throw InvalidOperationException();
    }
    _re.setRange(0, length, other._re);
    _im.setRange(0, length, other._im);
    return this;
  }

  Complex operator [](int idx) => Complex(re: _re[idx], im: _im[idx]);

  // void operator []=(int idx, Complex value) {
  //   _re[idx] = value.re.toDouble();
  //   _im[idx] = value.im.toDouble();
  // }

  double re(int idx) => _re[idx];
  double im(int idx) => _im[idx];

  void _zero() {
    for (var i = 0; i < length; i++) {
      _re[i] = 0;
      _im[i] = 0;
    }
  }

  void _swap(Float64List values, int i1, int i2) {
    final v = values[i1];
    values[i1] = values[i2];
    values[i2] = v;
  }

  void swap(int i1, int i2) {
    _swap(_re, i1, i2);
    _swap(_im, i1, i2);
  }

  double modulus2(int idx) {
    final r = _re[idx];
    final i = _im[idx];
    return r * r + i * i;
  }

  void neg(int idx) {
    _re[idx] = -_re[idx];
    _im[idx] = -_im[idx];
  }

  void conj(int idx) {
    _im[idx] = -_im[idx];
  }

  void inv(int idx) {
    final re = _re[idx];
    final im = _im[idx];
    final d = re * re + im * im;
    _re[idx] = re / d;
    _im[idx] = -im / d;
  }

  void add(int idx, ComplexArray a, int ai, ComplexArray b, int bi) {
    _re[idx] = a._re[ai] + b._re[bi];
    _im[idx] = a._im[ai] + b._im[bi];
  }

  void sub(int idx, ComplexArray a, int ai, ComplexArray b, int bi) {
    _re[idx] = a._re[ai] - b._re[bi];
    _im[idx] = a._im[ai] - b._im[bi];
  }

  void mul(int idx, ComplexArray a, int ai, ComplexArray b, int bi) {
    final are = a._re[ai];
    final aim = a._im[ai];
    final bre = b._re[bi];
    final bim = b._im[bi];
    _re[idx] = are * bre - aim * bim;
    _im[idx] = are * bim + aim * bre;
  }

  void div(int idx, ComplexArray a, int ai, ComplexArray b, int bi) {
    final are = a._re[ai];
    final aim = a._im[ai];
    final bre = b._re[bi];
    final bim = b._im[bi];
    final d = bre * bre + bim * bim;
    _re[idx] = (are * bre + aim * bim) / d;
    _im[idx] = (aim * bre - are * bim) / d;
  }

  void addmul(int idx, ComplexArray a, int ai, ComplexArray b, int bi) {
    final are = a._re[ai];
    final aim = a._im[ai];
    final bre = b._re[bi];
    final bim = b._im[bi];
    _re[idx] += are * bre - aim * bim;
    _im[idx] += are * bim + aim * bre;
  }

  bool isZero(int idx) => _re[idx] == 0 && _im[idx] == 0;

  void set(int idx, Complex value) {
    _re[idx] = value.re.toDouble();
    _im[idx] = value.im.toDouble();
  }

  void assign(int idx, ComplexArray a, int ai) {
    _re[idx] = a._re[ai];
    _im[idx] = a._im[ai];
  }

  void scale(Object factor) {
    if (factor is num) {
      if (factor == 0) {
        _zero();
      } else if (factor == 1) {
        // nothing to do
      } else {
        for (var i = 0; i < length; i++) {
          _re[i] *= factor;
          _im[i] *= factor;
        }
      }
    } else if (factor is Complex) {
      if (factor == Complex.one) {
        _zero();
      } else if (factor == Complex.one) {
        // nothing to do
      } else {
        final fre = factor.re;
        final fim = factor.im;
        for (var i = 0; i < length; i++) {
          final re = _re[i];
          final im = _im[i];
          _re[i] = re * fre - im * fim;
          _im[i] = re * fim + im * fre;
        }
      }
    } else {
      throw InvalidOperationException();
    }
  }

  void unscale(Object factor) {
    if (factor is num) {
      if (factor == 1) {
        // nothing to do
      } else {
        for (var i = 0; i < length; i++) {
          _re[i] /= factor;
          _im[i] /= factor;
        }
      }
    } else if (factor is Complex) {
      if (factor == Complex.one) {
        // nothing to do
      } else {
        final fre = factor.re;
        final fim = factor.im;
        final d = fre * fre + fim * fim;
        for (var i = 0; i < length; i++) {
          final re = _re[i];
          final im = _im[i];
          _re[i] = (re * fre + im * fim) / d;
          _im[i] = (im * fre - re * fim) / d;
        }
      }
    } else {
      throw InvalidOperationException();
    }
  }

  @override
  bool operator ==(Object other) {
    if (other is! ComplexArray || length != other.length) {
      return false;
    }
    for (var i = 0; i < length; i++) {
      if (_re[i] != other._re[i] || _im[i] != other._im[i]) {
        return false;
      }
    }
    return true;
  }

  @override
  int get hashCode => length.hashCode;

  @override
  String toString() =>
      '[' +
      Iterable.generate(
              length, (i) => '${_re[i].normalize()} + ${_im[i].normalize()} i')
          .join(', ') +
      ']';
}
