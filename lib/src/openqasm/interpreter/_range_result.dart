class RangeResult {
  RangeResult(this.start, this.stop, this.step);

  final int start;
  final int stop;
  final int step;

  Iterable<int> get values sync* {
    if (step > 0) {
      for (var i = start; i < stop; i += step) {
        yield i;
      }
    } else {
      for (var i = start; i > stop; i += step) {
        yield i;
      }
    }
  }

  @override
  String toString() => 'Range($start:$stop:$step)';
}
