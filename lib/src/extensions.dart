extension DoubleExt on num {
  bool equals(num other, {double precision = 0}) {
    final diff = (this - other).toDouble().abs();
    return diff == 0 || diff < precision;
  }

  static final sensitivity = 1e-13;

  num normalize() =>
      (isInfinite || isNaN || (this - toInt()).abs() > sensitivity)
          ? this
          : toInt();
}
