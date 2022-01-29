import 'package:test/expect.dart';

import 'package:qartvm/src/math/complex_matrix.dart';
import 'package:qartvm/src/math/complex.dart';

Matcher complexEquals(Complex expected, {double precision = 0}) =>
    _ComplexEqualsMatcher(expected, precision);

class _ComplexEqualsMatcher extends Matcher {
  final Complex _value;
  final double precision;

  _ComplexEqualsMatcher(this._value, this.precision);

  @override
  Description describe(Description description) =>
      description.addDescriptionOf(_value);

  @override
  bool matches(dynamic item, Map matchState) {
    if (item is Complex) {
      return _value.equals(item, precision: precision);
    } else {
      addStateInfo(matchState, {'mismatch': 'not a Complex number'});
      return false;
    }
  }
}

Matcher complexMatrixEquals(ComplexMatrix expected, {double precision = 0}) =>
    _ComplexMatrixEqualsMatcher(expected, precision);

class _ComplexMatrixEqualsMatcher extends Matcher {
  final ComplexMatrix _value;
  final double precision;

  _ComplexMatrixEqualsMatcher(this._value, this.precision);

  @override
  Description describe(Description description) =>
      description.addDescriptionOf(_value);

  @override
  Description describeMismatch(dynamic item, Description mismatchDescription,
      Map matchState, bool verbose) {
    final message = matchState['mismatch'];
    if (message != null) {
      mismatchDescription.replace(message);
    }
    return mismatchDescription;
  }

  @override
  bool matches(dynamic item, Map matchState) {
    if (item is ComplexMatrix) {
      if (item.rows != _value.rows || item.columns != _value.columns) {
        addStateInfo(matchState, {
          'mismatch':
              'invalid size: expected ${_value.rows}x${_value.columns}, found ${item.rows}x${item.columns}'
        });
        return false;
      }
      if (!_value.equals(item, precision: precision)) {
        return false;
      }
      return true;
    } else {
      addStateInfo(matchState, {'mismatch': 'not a ComplexMatrix'});
      return false;
    }
  }
}
