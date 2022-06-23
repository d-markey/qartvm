extension DoubleExt on num {
  /// Returns `true` if this instance and [other] are equal down to a precision of [precision]
  bool equals(num other, {double precision = 0}) {
    final diff = (this - other).abs();
    return diff == 0 || diff < precision;
  }

  /// Constant used for precision in [normalize]
  static final sensitivity = 1e-12;

  /// Returns an [int] if this instance is within [sensitivity] of the closest integer
  /// Otherwise returns this insance
  num normalize() {
    if (isInfinite || isNaN) return this;
    var i = ceil();
    if ((this - i).abs() < sensitivity) return i;
    i = floor();
    if ((this - i).abs() < sensitivity) return i;
    return this;
  }
}
