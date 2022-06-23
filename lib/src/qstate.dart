import 'dart:math' as math;

import 'qmemory_space.dart';

/// Class representing the Quantum state of a qubit
class QState {
  static final _rnd = math.Random.secure();

  /// Builds a Quantum state for qubit [id] in [_qmem]
  QState._(this._qmem, this.id)
      : _mask =
            Iterable.generate(_qmem.size, (i) => (i == id) ? '0' : '.').join();

  /// The qubit's [id]
  final int id;

  final String _mask;
  final QMemorySpace _qmem;

  /// Returns the probability for the qubit to be |0> according to the current state of the [_qmem]
  double get zero => _qmem.getPropability(_mask);

  /// Returns the qubit state: `'0'` or `'1'` if the qubit has already been measured,
  /// `null` otherwise.
  String? get state => _state;
  String? _state;

  // Measures the qubit (unless a measurement was already made) and returns the result
  String _read() {
    if (_state != null) {
      return _state!;
    } else {
      if (zero >= 0.5) {
        return (_state = (_rnd.nextDouble() <= zero) ? '0' : '1');
      } else {
        return (_state = (_rnd.nextDouble() > zero) ? '1' : '0');
      }
    }
  }

  // Resets the qubit state after a Quantum gate has been applied to the register.
  void _reset() => _state = null;
}

// for internal use
extension QStateImpl on QState {
  static QState ctor(QMemorySpace qmem, int id) => QState._(qmem, id);

  void reset() => _reset();
  void read() => _read();
}
