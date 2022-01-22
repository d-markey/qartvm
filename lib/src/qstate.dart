import 'dart:math' as math;

import 'qregister.dart';

class QState {
  static final _rnd = math.Random.secure();

  QState(this.id, this._register)
      : _mask = Iterable.generate(_register.size, (i) => i == id ? '0' : '.')
            .join();

  final int id;
  final String _mask;
  final QRegister _register;

  double get zero => _register.getPropability(_mask);

  String? _state;
  String? get state => _state;

  // measure unless a measurement was already made
  String measure() {
    if (_state == null) {
      final zero = this.zero;
      final one = 1 - zero;
      if (zero >= one) {
        _state = (_rnd.nextDouble() < zero) ? '0' : '1';
      } else {
        _state = (_rnd.nextDouble() < one) ? '1' : '0';
      }
      // print('   [$id] 0: $zero / 1: $one => $_state');
    }
    return state!;
  }

  // a transformation has been applied
  void unmeasure() {
    _state = null;
  }
}
